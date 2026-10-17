# Spanish tutor

Spanish lessons with Claude Code, using the [Fluent](https://github.com/m98/fluent) plugin.

## How to use it

1. Start a **new session** on this repo (choose Sonnet or Haiku to save usage).
2. First time only: type `/fluent-setup`.
3. Every lesson after that: type `/fluent-learn`.
4. Other commands: `/fluent-vocab`, `/fluent-review`, `/fluent-progress`.

Your progress lives in `data/` and lesson notes in `results/`. They are saved
to GitHub automatically after each of Claude's replies, so a new session picks
up where you left off.

## Tips

- One lesson per session. Long sessions cost more usage per message.
- Don't run two sessions at the same time; they may overwrite each other's progress.
- Don't edit or delete files in `data/` by hand.
