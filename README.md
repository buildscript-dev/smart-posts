# Oriflame Smart Posts — Brandie Flutter Assignment

A single-page Flutter implementation of the **Quick Share / Smart Posts** feature
from the provided Figma design: an AI-generated, ready-to-share product post feed
for Oriflame consultants, with one-tap sharing to social platforms.

## How to run

```bash
flutter pub get
flutter run          # any device; demoed on a real Android device
```

No backend — all data is hardcoded (`lib/data/mock_posts.dart`), as the brief
recommends.

## Demo flow

1. **Loading** — "Building personalised Smart Posts for you!" checklist animates
   through its 4 steps (long-press toggles dark mode, whose variant also exists
   in the Figma LOADING section).
2. **Smart Post feed** — 3 posts, vertical reels-style swipe (designer note:
   *"Show 3 posts. User can scroll like reels"*). Header, tabs, page dots and
   bottom nav stay persistent; only the media area pages.
3. **Product card** (post 1) — fades in from the bottom after 3 seconds, fully
   clickable (both from the designer's annotations), and randomly shows either
   Figma variant: the trending message or the compact price card.
4. **Edit Caption** — tap the caption block. Opens without the keyboard; tapping
   the text focuses it; **Save enables only when the text actually changes**
   (per the annotation "Enable Save button when a change is made"). Saved edits
   replace the caption in the feed and in the shared text.
5. **Quick share** — tap any platform icon → the Figma 4-stage loading sequence
   ("Generating your sales link.." → clipboard → profile → social prep) → the
   platform's **real app opens** (WhatsApp/Telegram get the caption prefilled);
   if the app isn't installed, its website opens in the browser instead. The
   icon row is horizontally scrollable (annotation: "This list is scrollable").
6. **Everything else works** — Library / Communities / Share&Win top tabs,
   bottom-nav Home dashboard, Search, Chats, Profile with a gallery that
   collects real camera shots (camera button → system camera), a local
   rule-based AI assistant, and a light/dark theme toggle in Profile.

## Structure

```
lib/
  app/theme.dart          # design tokens sampled pixel-exact from the frames
  data/                   # models + hardcoded posts
  shared/                 # chrome reused across screens (header, tabs,
                          # bottom nav, frosted blur panel)
  features/
    loading/              # animated checklist screen (light + dark)
    smart_post/           # feed screen + overlay widgets
    edit_caption/         # caption editor with dirty-state Save
    share/                # generating-link dialog + Instagram handoff
```

## Assumptions & decisions

- **Colors** were sampled from the exported frames (`#73BF98` brand green,
  `#9ED5AD` mint, `#00725B` deep green badge, `#EB858C→#C9A6E0` pill gradient,
  `#090B0E` dark background, `#F3E6D4` cream).
- **Typeface**: the design uses a geometric single-story-'a' face (Century
  Gothic family). Closest free match is **Jost** via `google_fonts`.
- **Persistent chrome**: header/tabs/nav sit outside the vertical `PageView` —
  they are pixel-identical across all three post frames, and a real reels
  implementation doesn't rebuild chrome during swipes.
- **Imagery** (post photos, avatar, logo, platform icons) was cropped from the
  supplied design exports so the UI stays visually identical to the wireframe.
- The share flow ends in a *simulated* Instagram splash — the brief asks for
  minimal backend/API work, so the OS handoff is presented as a screen.
