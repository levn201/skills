This is Levin's personal skills repo, forked from [mattpocock/skills](https://github.com/mattpocock/skills). Skills are organized into bucket folders under `skills/`:

- `engineering/`: daily code work
- `productivity/`: daily non-code workflow tools
- `deprecated/`: no longer used

Every skill in `engineering/` or `productivity/` must have an entry in its bucket `README.md`, in the top-level `README.md`, and in `.claude-plugin/plugin.json`'s `skills` array. Run `claude plugin validate . --strict` after touching `plugin.json` or `marketplace.json`.

Each bucket `README.md` and the top-level `README.md` group skills into **User-invoked** and **Model-invoked**, with the skill name linked to its `SKILL.md`.

Every `SKILL.md` is either user-invoked (`disable-model-invocation: true` plus `policy.allow_implicit_invocation: false` in `agents/openai.yaml`, reachable only by the human) or model-invoked (model- or user-reachable). See [.agents/invocation.md](./.agents/invocation.md).

[`ask-levin`](./skills/engineering/ask-levin/SKILL.md) is the router that maps every user-reachable skill and how they relate. Whenever you add, rename, remove, or change how a user-reachable skill fits the flows, update `ask-levin` so the map stays accurate: a router that routes to a missing skill, or misses a new one, lies.

`docs/<bucket>/<skill-name>.md` are the upstream human-facing explanations. They are reference only. Update a page when you change that skill's behaviour, delete it when you delete the skill, but a new skill does not need one.

`scripts/link-skills.sh` symlinks every skill into `~/.claude/skills` and `~/.agents/skills`, so edits here are live immediately. Re-run it after adding, removing, or renaming a skill.

`scripts/upstream-changes.sh` compares against `mattpocock/skills` from the commit in `.upstream-sync`. Never `git merge upstream/main`: this repo renames and rewrites skills, so take changes over per file.

The issue tracker for skills that need one is GitHub Issues (via `gh`), configured per project by `/setup-levin-skills`.

No em-dashes in this repo's prose. Where a sentence reaches for one, rewrite it with a comma, colon, period, parentheses, or a conjunction.

Every skill that dispatches a subagent says to start it with a fresh context window.
