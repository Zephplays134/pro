# 🚢 Set Sail: Cruise Line — Coming 2026

A Roblox cruise-ship simulator game concept, built as a starter Rojo project you can sync straight into Roblox Studio.

## Concept

Players explore a massive cruise ship, unlock decks (Pool, Casino, Buffet, Captain's Bridge, Luxury Suites) with coins earned from onboard mini-games, and watch the ship "dock" at rotating fictional ports every 20 minutes. A pulsing **"COMING 2026"** teaser splash plays when the game loads — perfect for a pre-launch demo/trailer build.

## What's included

```
default.project.json                # Rojo project file
src/ReplicatedStorage/
  GameConfig.lua                    # game name, launch year, rewards, decks, ports
  RemoteEvents.lua                  # shared RemoteEvent/RemoteFunction registry
src/ServerScriptService/
  PlayerDataService.server.lua      # coins + deck unlocks, DataStore save/load
  PortRotationService.server.lua    # rotates the ship between ports on a timer
src/StarterGui/
  TeaserScreen.client.lua           # animated "COMING 2026" splash screen
  HudScreen.client.lua              # coin counter + "Now Docking at..." banner
src/StarterPlayerScripts/
  MiniGameTriggers.client.lua       # touch-parts that trigger mini-game payouts
```

## How to use it (Roblox Studio)

1. **Install [Rojo](https://rojo.space/)** (VS Code extension + the Roblox Studio plugin).
2. Download/copy this `files/` folder to your computer.
3. Open the folder in VS Code, then in Roblox Studio open a new **Baseplate** place and connect Rojo (`rojo serve` in the folder, then "Connect" in the Studio plugin).
4. In Studio, build/import your cruise ship model into `Workspace`. Add simple `Part`s named:
   - `BuffetTrigger`, `PoolTrigger`, `CasinoTrigger` — placed on the corresponding decks — to award coins when players touch them.
5. Press **Play** — you'll see the "COMING 2026" splash, then the HUD with a coin counter and port-arrival banner.

*(No Rojo? You can also just copy each `.lua` file's contents into a matching Script/LocalScript/ModuleScript inside the right service in Studio manually — the code doesn't depend on Rojo at runtime.)*

## Customize it

- Edit `GameConfig.lua` to rename the game, change the launch year/teaser text, add more decks or ports, or tweak coin rewards.
- Add more mini-games by adding new touch-trigger names to `MiniGameTriggers.client.lua`'s `TRIGGER_MAP` and a matching branch in `PlayerDataService.server.lua`.
- Swap the teaser splash's colors/text for your own branding/trailer style.

## Suggested next steps for a full 2026 launch

- Build the actual ship model (or buy/import a cruise ship asset) and lay out multiple decks matching `GameConfig.Decks`.
- Add a "Buy Robux passes" monetization layer for VIP suites or a private yacht.
- Add a leaderboard (`leaderstats`) so coins show above players' heads in-game.
- Add a trailer using the teaser screen's visual style before your 2026 release.
