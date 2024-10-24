import gleam/io
import gleam/json
import gleam/option.{type Option, None, Some}
import lustre
import lustre/attribute.{type Attribute}
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import widgets/browser
import widgets/component.{type Component, Component}
import widgets/component/article
import widgets/helper/json_helper

pub fn main() {
  let components = load_components()

  let app = lustre.application(init, update, render)
  case lustre.start(app, "#app", components) {
    Ok(_) -> io.println("editor is running")
    Error(message) -> {
      io.println_error("Error starting app")
      io.debug(message)
      panic as "Could not start app"
    }
  }
}

type State {
  State(components: List(Component(Message, ComponentData)))
}

type ComponentData {
  ComponentData(hovered: Bool)
}

fn component_data(component: Component(Message, ComponentData)) -> ComponentData {
  case component.data {
    Some(data) -> data
    None -> ComponentData(hovered: False)
  }
}

type Message {
  MouseOver(id: Int)
  MouseLeafe(id: Int)
}

fn init(
  components: List(Component(Message, ComponentData)),
) -> #(State, Effect(Message)) {
  let components =
    component.walk_map(
      components,
      fn(component: Component(Message, ComponentData)) {
        Component(
          ..component,
          attributes: component_attributes(
            component.id,
            component_data(component),
          ),
        )
      },
    )

  #(State(components: components), effect.none())
}

fn component_attributes(
  id: Int,
  data: ComponentData,
) -> List(Attribute(Message)) {
  let result = [
    attribute.on("mouseover", fn(_) { Ok(MouseOver(id)) }),
    attribute.on("mouseleave", fn(_) { Ok(MouseLeafe(id)) }),
  ]

  let result = case data.hovered {
    True -> [attribute.class("bg-success"), ..result]
    False -> result
  }

  result
}

fn update(state: State, msg: Message) -> #(State, Effect(Message)) {
  let components = case msg {
    MouseOver(id) | MouseLeafe(id) ->
      component.update(
        state.components,
        id,
        fn(component: Component(Message, ComponentData)) {
          let data =
            ComponentData(hovered: case msg {
              MouseOver(_) -> True
              MouseLeafe(_) -> False
            })

          Component(
            ..component,
            data: Some(data),
            attributes: component_attributes(id, data),
          )
        },
      )
  }
  #(State(components: components), effect.none())
}

fn render(state: State) -> Element(Message) {
  element.fragment(component.render(state.components))
}

fn get_hydration_state() -> Option(String) {
  let state = browser.hydration_state("hydration")
  let state = case state {
    Ok(None) -> browser.hydration_state("hydration-dev")
    _ -> state
  }

  case state {
    Ok(Some(state)) -> Some(state)
    Error(err) -> {
      io.println_error("Error getting hydration state:")
      io.println_error(err)

      panic as "Could not get hydration state"
    }
    Ok(None) -> None
  }
}

fn default_components() -> List(Component(Message, ComponentData)) {
  [
    component.navbar(
      [component.article(article.text("Start"))],
      [component.article(article.text("Center"))],
      [component.article(article.text("End"))],
    ),
    component.navbar(
      [],
      [
        component.article(article.text("A")),
        component.article(article.text("B")),
        component.article(article.text("C")),
      ],
      [],
    ),
    component.article(article.text("Hello from dev mode!")),
    component.article(article.djot("_This is *regular* not strong* emphasis")),
    component.article(article.djot("*This is _strong* not regular_ emphasis")),
    component.article(article.djot("[Link *](url)*")),
    component.article(article.djot("*Emphasis [*](url)")),
    component.article(article.djot("_This is *strong within* regular emphasis_")),
    component.article(article.djot(
      "{_Emphasized_}
                           _}not emphasized{_",
    )),
    component.article(article.djot("*not strong *strong*")),
    component.article(article.djot("[My link text](http://example.com)")),
    component.article(article.djot(
      "[My link text](http://example.com?product_number=234234234234234234234234)",
    )),
    component.article(article.djot(
      "[My link text][foo bar]
             
                         [foo bar]: http://example.com",
    )),
    component.article(article.djot("[foo][bar]")),
    component.article(article.djot(
      "``Verbatim with a backtick` character``
             `Verbatim with three backticks ``` character`",
    )),
    component.article(article.djot("This is {=highlighted text=}.")),
    component.article(article.djot("H~2~O and djot^TM^")),
    component.article(article.djot("H{~one two buckle my shoe~}O")),
    component.article(article.djot("My boss is {-mean-}{+nice+}.")),
  ]
}

fn load_components() -> List(Component(Message, ComponentData)) {
  let hydration = get_hydration_state()
  case hydration {
    Some(json_string) ->
      case json.decode(json_string, component.decoder()) {
        Ok([]) -> default_components()
        Ok(components) -> components
        Error(error) -> {
          io.println_error("Error decoding component json:")
          io.println_error(json_string)
          io.println_error("Error:")
          io.println_error(json_helper.stringify_decode_error(error))

          panic as "Could not decode components"
        }
      }
    None -> default_components()
  }
}
