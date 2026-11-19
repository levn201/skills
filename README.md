# Levin's Skills

Meine persönlichen Agent-Skills für Claude Code, geforkt von [mattpocock/skills](https://github.com/mattpocock/skills) und auf das reduziert, was ich tatsächlich nutze. Issues landen auf GitHub, die Skills selbst bleiben auf Englisch.

## Installation

**Für den täglichen Einsatz, während ich an den Skills arbeite** (Änderungen wirken sofort):

```bash
git clone https://github.com/levn201/skills.git ~/levin-skills
~/levin-skills/scripts/link-skills.sh
```

Das verlinkt jeden Skill per Symlink nach `~/.claude/skills`. Nach dem Hinzufügen, Entfernen oder Umbenennen eines Skills erneut ausführen.

**Als Claude-Code-Plugin** (auf einem anderen Rechner, nur lesend):

```
/plugin marketplace add levn201/skills
/plugin install levin-skills@levin
```

Nur eine der beiden Varianten wählen. Beide gleichzeitig ergeben jeden Skill doppelt.

Danach in jedem Projekt einmal `/setup-levin-skills` ausführen. Das schreibt die GitHub-Issue-Tracker-Konfiguration, die die Engineering-Skills brauchen. Unsicher, welcher Skill passt? `/ask-levin` ausführen.

## Skills

**Vom Nutzer aufgerufen** heißt: Du startest den Skill selbst per `/name`. **Vom Modell aufgerufen** heißt: Claude lädt den Skill selbstständig, wenn die Situation passt.

### Engineering

**Vom Nutzer aufgerufen**

- **[ask-levin](./skills/engineering/ask-levin/SKILL.md)**: Fragt, welcher Skill oder Ablauf zu deiner Situation passt. Ein Wegweiser über alle vom Nutzer aufgerufenen Skills in diesem Repo.
- **[grill-with-docs](./skills/engineering/grill-with-docs/SKILL.md)**: Eine Grilling-Session, die nebenbei das Domänenmodell des Projekts aufbaut: Begriffe werden geschärft, `GLOSSARY.md` und ADRs direkt mitgepflegt.
- **[triage](./skills/engineering/triage/SKILL.md)**: Führt Issues durch eine Zustandsmaschine aus Triage-Rollen.
- **[improve-codebase-architecture](./skills/engineering/improve-codebase-architecture/SKILL.md)**: Durchsucht eine Codebase nach Möglichkeiten, Module zu vertiefen, zeigt sie als visuellen HTML-Bericht und grillt dich anschließend zu der Option, die du auswählst.
- **[setup-levin-skills](./skills/engineering/setup-levin-skills/SKILL.md)**: Richtet ein Repo für die Engineering-Skills ein (Issue-Tracker, Triage-Labels, Ablage der Domänen-Dokumente). Einmal pro Repo ausführen.
- **[to-spec](./skills/engineering/to-spec/SKILL.md)**: Macht aus dem aktuellen Gespräch eine Spezifikation und veröffentlicht sie im Issue-Tracker.
- **[to-tickets](./skills/engineering/to-tickets/SKILL.md)**: Zerlegt einen Plan, eine Spec oder ein Gespräch in Tracer-Bullet-Tickets, die jeweils angeben, wovon sie blockiert werden – entweder als Text in einer lokalen Datei oder als echte Blocking-Links im Tracker.
- **[implement](./skills/engineering/implement/SKILL.md)**: Setzt die Arbeit aus einer Spec oder einem Ticket-Set um, nutzt `/tdd` an vorher vereinbarten Schnittstellen und schließt vor dem Commit mit `/code-review` ab.
- **[implement-spec](./skills/engineering/implement-spec/SKILL.md)**: Setzt eine komplette Spec auf einem Integrations-Branch um. Arbeitet die Tickets als Aufgabengraph ab, lässt Implementierer-Subagents parallel über alle gerade bereiten Tickets laufen und schließt mit `/code-review` ab.
- **[wayfinder](./skills/engineering/wayfinder/SKILL.md)**: Plant ein sehr großes Vorhaben (mehr, als eine Agent-Session fassen kann) als gemeinsame Karte aus Entscheidungs-Tickets im Issue-Tracker, die nacheinander geklärt werden, bis der Weg zum Ziel feststeht.
- **[retro](./skills/engineering/retro/SKILL.md)**: Schlägt nach einer Session Verbesserungen an der Umgebung des Coding-Agents vor (Navigation, automatische Checks, Coding-Standards, Steuerungsdateien, Tooling) – die gravierendsten zuerst.

**Vom Modell aufgerufen**

- **[prototype](./skills/engineering/prototype/SKILL.md)**: Baut einen Wegwerf-Prototyp, um eine Designfrage zu beantworten: eine einzelne teilbare HTML-Datei für Zustand/Logik oder mehrere umschaltbare UI-Varianten.
- **[diagnosing-bugs](./skills/engineering/diagnosing-bugs/SKILL.md)**: Disziplinierte Diagnoseschleife für schwierige Bugs und Performance-Regressionen: eine Feedback-Schleife bauen, die bei diesem Bug rot wird → minimieren → Hypothese aufstellen → instrumentieren → fixen → Regressionstest.
- **[research](./skills/engineering/research/SKILL.md)**: Untersucht eine Frage anhand vertrauenswürdiger Primärquellen und hält die Ergebnisse als Markdown-Datei mit Quellenangaben im Repo fest; läuft als Hintergrund-Agent.
- **[tdd](./skills/engineering/tdd/SKILL.md)**: Testgetriebene Entwicklung mit Red-Green-Refactor-Schleife. Baut Features oder behebt Bugs Schritt für Schritt in vertikalen Scheiben.
- **[domain-modeling](./skills/engineering/domain-modeling/SKILL.md)**: Baut das Domänenmodell eines Projekts aktiv auf und schärft es, indem Begriffe hinterfragt, mit Szenarien auf die Probe gestellt und `GLOSSARY.md` sowie ADRs direkt aktualisiert werden.
- **[codebase-design](./skills/engineering/codebase-design/SKILL.md)**: Gemeinsame Disziplin und Begriffe für das Entwerfen tiefer Module: kleine Schnittstellen, saubere Nahtstellen, über die Schnittstelle testbar.
- **[code-review](./skills/engineering/code-review/SKILL.md)**: Review des Diffs seit einem festen Punkt entlang zweier Achsen: **Standards** (hält sich der Code an die Coding-Standards des Repos, plus eine Basis aus Fowlers Code-Smells?) und **Spec** (setzt er das ursprüngliche Issue bzw. die Spec getreu um?), ausgeführt als parallele Subagents.
- **[pr](./skills/engineering/pr/SKILL.md)**: Die Form, die eine Pull-Request-Beschreibung haben sollte: eine Zusammenfassung als kleinstmögliche Darstellung, die die Änderung klar macht, Vorher/Nachher-Belege, dass es funktioniert, und eine Einschätzung des Merge-Risikos (Einweg- oder Zweiwegtür, plus Auswirkungsradius).
- **[wizard](./skills/engineering/wizard/SKILL.md)**: Erzeugt einen interaktiven Bash-Wizard, der einen Menschen durch Schritte führt, die nur er selbst erledigen kann: Infrastruktur bereitstellen, Zugangsdaten oder CI-Secrets einrichten, sich durch ein unbekanntes Dashboard eines Drittanbieters klicken oder eine einmalige Migration bzw. Umstellung durchführen.
- **[ausbilder](./skills/engineering/ausbilder/SKILL.md)**: Coacht dich wie ein Ausbilder, statt den Code selbst zu schreiben: legt das Ziel fest, erklärt Schritt für Schritt, was zu tun ist und warum, gibt gestufte Hinweise und prüft nach jedem Schritt deinen Code. Der Fortschritt wird in `AUSBILDUNG.md` gespeichert.

### Produktivität

**Vom Nutzer aufgerufen**

- **[grill-me](./skills/productivity/grill-me/SKILL.md)**: Lass dich unerbittlich zu einem Plan oder Design befragen, bis jeder Zweig des Entscheidungsbaums geklärt ist.
- **[handoff](./skills/productivity/handoff/SKILL.md)**: Verdichtet das aktuelle Gespräch zu einem Übergabedokument, damit ein anderer Agent die Arbeit fortsetzen kann.
- **[teach](./skills/productivity/teach/SKILL.md)**: Bringt dir über mehrere Sessions hinweg eine neue Fähigkeit oder ein neues Konzept bei und nutzt das aktuelle Verzeichnis als Lern-Arbeitsbereich mit Gedächtnis.
- **[to-questionnaire](./skills/productivity/to-questionnaire/SKILL.md)**: Macht aus einer Entscheidung, die du nicht allein treffen kannst, einen Markdown-Fragebogen für die eine Person, die sie beantworten kann (asynchron ausgefüllt oder gemeinsam in einem Meeting).
- **[wait-what](./skills/productivity/wait-what/SKILL.md)**: Aufrufen, sobald eine Nachricht nicht ankommt. Der Agent erklärt sie neu, mit dem Kontext, der dir fehlt, in einfacher Sprache und mit den Begriffen aus deiner `GLOSSARY.md`.

**Vom Modell aufgerufen**

- **[grilling](./skills/productivity/grilling/SKILL.md)**: Befragt den Nutzer unerbittlich zu einem Plan, einer Entscheidung oder einer Idee, bis jeder Zweig des Entscheidungsbaums geklärt ist.
- **[git-guardrails-claude-code](./skills/productivity/git-guardrails-claude-code/SKILL.md)**: Richtet Claude-Code-Hooks ein, die gefährliche Git-Befehle (push, reset --hard, clean usw.) blockieren, bevor sie ausgeführt werden.
- **[writing-for-agents](./skills/productivity/writing-for-agents/SKILL.md)**: Dokumente für Agents schreiben: Skills, AGENTS.md/CLAUDE.md und jedes Dokument, zu dem ein Agent über einen Verweis gelangt.

## Credits

Basiert auf [mattpocock/skills](https://github.com/mattpocock/skills) von Matt Pocock, MIT-lizenziert. Der Ordner `docs/` enthält seine ausführlicheren Erklärungen zu den einzelnen Skills.
