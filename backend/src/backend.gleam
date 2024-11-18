import backend/database
import backend/middleware/middleware
import backend/tailwind
import gleam/erlang/process
import gleam/io
import gleam/json
import gleam/string_tree
import lustre/attribute
import lustre/element
import lustre/element/html
import mist
import simplifile
import widgets/component.{type Component}
import widgets/component/article
import widgets/component/container
import widgets/tailwind/class/typography
import wisp.{type Request, type Response}
import wisp/wisp_mist

pub fn main() {
  case simplifile.create_directory_all("./data") {
    Ok(_) -> Nil
    Error(error) -> {
      io.println_error("Error creating data directory:")
      io.debug(error)
      panic as "Could not create data directory"
    }
  }

  let _db = case database.connect("./data/database.sqlite", 20) {
    Ok(db) -> db
    Error(error) -> {
      io.println_error("Error connecting to database:")
      io.debug(error)
      panic as "Could not connect to database"
    }
  }

  // TODO: Don't assume, start the app in a failed state and
  // output error messages so the pages can be accessed
  let assert Ok(_) = tailwind.delete_temporary_files()

  let secret_key_base = wisp.random_string(64)

  let assert Ok(_) =
    wisp_mist.handler(handle_request(), secret_key_base)
    |> mist.new
    |> mist.bind("0.0.0.0")
    |> mist.port(8161)
    |> mist.start_http

  process.sleep_forever()
}

fn content() -> fn(Request) -> #(List(Component(a, d)), String) {
  let components = [
    component.br(),
    component.br(),
    component.container(
      container.new(component.interface(), [
        component.article(
          article.djot(
            "
{.text-primary .motion-preset-confetti .motion-duration-[2s]}
# 🛠️ Baukasten - CMS: Einfach. Schnell. Anpassbar. 🚀

{.motion-preset-slide-right .motion-duration-1500}
Erstelle beeindruckende Webseiten ohne Vorkenntnisse.

{.motion-preset-slide-right .motion-duration-1500 .motion-delay-[150ms]}
🚧 *Dieses Projekt befindet sich noch in einer frühen Entwicklungsphase.* 🚧

{.motion-preset-bounce .motion-delay-[250ms]}
[Jetzt starten](#Installation) 📥 \\
[Mehr erfahren](#Funktionen) 📖

---

{.motion-preset-bounce .motion-delay-[500ms]}
## Hauptmerkmale auf einen Blick

{.motion-preset-bounce .motion-delay-[750ms]}
🛠️ *Benutzerfreundlich*\\
- Intuitive Komponenten für individuelle Gestaltung.

{.motion-preset-bounce .motion-delay-[1000ms]}
⚡ *Hohe Performance*\\
- Blitzschnelle Ladezeiten durch optimierte Technologie.

{.motion-preset-bounce .motion-delay-[1250ms]}
💰 *Geringe Kosten*\\
- Minimale Serverlast reduziert laufende Kosten.

{.motion-preset-bounce .motion-delay-[1500ms]}
🔒 *Stabil und Sicher*\\
- Moderne Programmierung für einen reibungslosen Betrieb.

{.motion-preset-bounce .motion-delay-[1750ms]}
🐳 *Einfache Installation*\\
- Starte sofort mit unserem Docker-Container.

---

## Funktionen

### Einfache Anpassung 🛠️

*Beschreibung:*

Passe deine Webseite flexibel an, ohne Programmierkenntnisse.

*Details:*

- Komponentenbasierte Struktur.\\
- Intuitive Benutzeroberfläche.

### Leistungsstarkes Backend ⚙️

*Beschreibung:*

Hohe Performance dank Erlang BEAM VM.

*Details:*

- Skalierbarkeit für wachsende Projekte.\\
- Effiziente Ressourcennutzung.

### Modernes Styling 🎨

*Beschreibung:*

Attraktives Design mit daisyUI 🌼 und Tailwind CSS.

*Details:*

- Individuelle Themes und Styles.\\
- Optimierte CSS-Dateien für schnelle Ladezeiten.

### Optimierte Architektur 🗄️

*Beschreibung:*

Schnelle Auslieferung durch Caching und Datenbank-Optimierung.

*Details:*

- Speicherung als JSON in SQLite.\\
- Vorkompilierte Inhalte für minimale Latenz.

### Einfache Installation 🐳

*Beschreibung:*

Starte sofort mit unserem Docker-Container.

*Details:*

- Ein einziger Befehl zum Ausführen des Containers.\\
- Alle benötigten Ressourcen sind bereits enthalten.

---

## Technologie

### Gleam Programmiersprache 💻

*Was ist Gleam?*

Eine funktionale Sprache mit sicherer Typisierung.

*Vorteile:*

- Skalierbarkeit und Zuverlässigkeit.\\
- Freundliche und inklusive Community.

### Erlang BEAM VM ⚙️

*Was ist die BEAM VM?*

Eine virtuelle Maschine für hochperformante Anwendungen.

*Vorteile:*

- Unterstützung paralleler Prozesse.\\
- Hohe Fehlertoleranz und Stabilität.

### Dual-Kompilierung 🌐

*Wie funktioniert das?*

Gleam kompiliert nach Erlang und JavaScript.

*Vorteile:*

- Einheitliche Codebasis für Frontend und Backend.\\
- Native Funktionen für optimale Performance.

### Styling mit daisyUI und Tailwind CSS 🌼

*Was ist daisyUI?*

Ein Plugin für Tailwind CSS zur Vereinfachung von UI-Designs.

*Vorteile:*

- Schnellere Entwicklung von ansprechenden Oberflächen.\\
- Konsistente Designs mit minimalem Aufwand.

---

## Wie es funktioniert

### Komponentenbasierte Struktur 🧩

*Erstellung von Komponenten:*

Baue wiederverwendbare Elemente wie Navigation oder Textblöcke.

*Rekursive Einbindung:*

Komponenten können andere Komponenten enthalten.

### Datenverwaltung 🗄️

*Speicherung als JSON:*

Serialisierung der Komponenten für die Datenbank.

*Bearbeitung und Anpassung:*

Einfache Deserialisierung für spätere Änderungen.

### Rendering-Prozess 🖥️

*HTML-Generierung:*

Durchlaufen des Komponentenbaums erzeugt den HTML-Code.

*CSS-Optimierung:*

Tailwind CSS generiert nur die benötigten Styles.

### Performance-Optimierung ⚡

*Caching-Mechanismus:*

Vorab geladene Ressourcen im Arbeitsspeicher.

*Schnelle Auslieferung:*

Direkte Antwort auf Anfragen ohne zusätzliche Berechnungen.

---

## Mission und Werte

### Unterstützung von Aktivismus ✊

*Unsere Motivation:*

Aktivisten eine Plattform bieten, um Gehör zu finden.

*Geringe Kosten:*

Optimierung für minimalen Ressourcenverbrauch.

### Gemeinschaft und Inklusion 🌱

*Unsere Werte:*

Linke, gemeinschaftliche und gerechte Prinzipien.

*Engagement:*

Gegen Ausbeutung von Mensch und Tier.

### Open Source und Zusammenarbeit 🤗

*Transparenz:*

Offener Quellcode für Vertrauen und Sicherheit.

*Mitmachen:*

Einladung an die Community zur Beteiligung und Erweiterung.

---

## Aktueller Entwicklungsstand

### 🚧 In Entwicklung 🚧

*Hinweis:*

*Baukasten* befindet sich noch in einer frühen Entwicklungsphase.

*Was bedeutet das?*

- Einige Funktionen sind noch nicht vollständig implementiert.\\
- Wir arbeiten kontinuierlich an Verbesserungen und neuen Features.

*Wie kannst du helfen?*

- Teste das CMS und gib Feedback.\\
- Beteilige dich an der Entwicklung auf GitHub.

---

## Installation

### Schneller Start mit Docker 🐳

*Einfacher Einstieg:*

Starte *Baukasten* mit nur einem Befehl.

*Schritt-für-Schritt-Anleitung:*

1. Installiere Docker auf deinem System.\\
2. Führe den folgenden Befehl aus:

```bash
docker run -d -p 8161:8161 ghcr.io/161-269/baukasten:latest
```

3. Besuche `http://localhost:8161` in deinem Browser.

*Vorteile:*\\
- Keine komplizierte Einrichtung\\
- Alle Abhängigkeiten sind enthalten.

---

Der Quellcode ist auf GitHub verfügbar:
[github.com/161-269/baukasten](https://github.com/161-269/baukasten)

_Hinweis:_\\
Diese Webseite wurde mit [Djot-Markup](https://github.com/jgm/djot) erstellt 
und kann direkt in das Baukasten CMS integriert werden.
            ",
          )
          |> article.size(typography.TextLg),
        ),
        component.br(),
        component.br(),
      ]),
    ),
  ]

  let assert Ok(tailwind_css) =
    tailwind.generate_css_for()([
      html.html([], [
        html.head([], []),
        html.body([], components |> component.render),
      ])
      |> element.to_document_string,
    ])

  fn(_req: Request) { #(components, tailwind_css) }
}

fn handle_request() -> fn(Request) -> Response {
  let middleware_handler = middleware()
  let components = content()

  fn(req: Request) {
    let #(components, tailwind_css) = components(req)
    use _req, path_segments <- middleware_handler(req, tailwind_css)

    let #(title, css, mjs, link_href, link_text) = case path_segments {
      ["edit"] -> #(
        "Editor",
        html.link([
          attribute.rel("stylesheet"),
          attribute.href("/static/editor.min.css"),
        ]),
        "editor.min.mjs",
        "/",
        "Zurück zur Startseite",
      )
      _ -> #(
        "Baukasten",
        element.none(),
        "widgets.min.mjs",
        "/edit",
        "Zum Editor",
      )
    }

    let result =
      html.html([attribute.attribute("lang", "de")], [
        html.head([], [
          html.meta([attribute.attribute("charset", "utf-8")]),
          html.meta([
            attribute.name("viewport"),
            attribute.attribute(
              "content",
              "width=device-width, initial-scale=1.0",
            ),
          ]),
          html.title([], "🛠️ " <> title),
          html.link([
            attribute.rel("stylesheet"),
            attribute.href("/static/fonts.css"),
          ]),
          html.link([
            attribute.rel("stylesheet"),
            attribute.href("/static/widgets.min.css"),
          ]),
          css,
          html.script(
            [
              attribute.attribute("defer", "defer"),
              attribute.type_("module"),
              attribute.src("/static/" <> mjs),
            ],
            "",
          ),
          html.script(
            [attribute.id("hydration"), attribute.type_("application/json")],
            components |> component.encode |> json.to_string,
          ),
        ]),
        html.body([], [
          html.div([attribute.id("app")], component.render(components)),
          html.a([attribute.href(link_href)], [html.text(link_text)]),
        ]),
      ])

    wisp.html_response(element.to_document_string_builder(result), 200)
  }
}

fn middleware() -> fn(
  wisp.Request,
  String,
  fn(wisp.Request, List(String)) -> wisp.Response,
) ->
  wisp.Response {
  let assert Ok(priv) = wisp.priv_directory("backend")

  let assert Ok(middleware) = middleware.new(True)
  let middleware_handler = middleware.handler(middleware)

  fn(
    req: wisp.Request,
    tailwind_css: String,
    handle_request: fn(wisp.Request, List(String)) -> wisp.Response,
  ) {
    use <- wisp.rescue_crashes
    let req = wisp.method_override(req)
    use req <- wisp.handle_head(req)
    use session <- middleware_handler(req)

    let path_segments = wisp.path_segments(req)

    let response = case path_segments == ["static", "widgets.min.css"] {
      True ->
        wisp.response(200)
        |> wisp.set_header("Content-Type", "text/css; charset=utf-8")
        |> wisp.set_body(wisp.Text(string_tree.from_string(tailwind_css)))
      False -> {
        use <- wisp.serve_static(req, under: "/static", from: priv)

        handle_request(req, path_segments)
      }
    }

    #(response, session)
  }
}
