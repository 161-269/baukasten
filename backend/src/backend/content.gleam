import backend/tailwind_new.{type Tailwind}
import lustre/element
import lustre/element/html
import widgets/component.{type Component}
import widgets/component/article
import widgets/component/container
import widgets/tailwind/class/typography
import wisp.{type Request}

pub fn content(tailwind: Tailwind) -> fn(Request) -> List(Component(a, d)) {
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

  tailwind_new.add_html(
    tailwind,
    html.html([], [
      html.head([], []),
      html.body([], components |> component.render),
    ])
      |> element.to_document_string,
  )
  fn(_req: Request) { components }
}
