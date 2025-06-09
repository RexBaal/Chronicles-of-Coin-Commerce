# AGENTS.md - AI Guidance for Medieval Economy RPG

## Project Overview
This project is a **2D Medieval Economic RPG** built with Godot 4.4 and GDScript. The player manages a village economy, trading goods, building shops, and interacting with NPCs. The game features farming, crafting, a marketplace, and NPC AI for villagers and merchants (note: in-game AI logic is handwritten; AI assistants are used only for development automation). The goal is to simulate an evolving economy and society in a medieval town.

## Project Structure 
- **res://scenes/** – Godot scene files, each typically paired with a GDScript:
  - **world/** – World map and location scenes (e.g. `WorldMap.tscn`, `Town.tscn` with their scripts).
  - **characters/** – Player and NPC scenes (e.g. `Player.tscn` & `Player.gd`, NPC variants).
  - **ui/** – User interface scenes (inventory menu, shop menu, HUD, etc.).
  - **economy/** – Scenes related to economy systems (e.g. `Market.tscn` for marketplace).
- **res://scripts/** – Standalone GDScript files (usually non-Node singleton classes or systems):
  - **economy/** – Economic logic (e.g. `Inventory.gd` managing player inventory, `Trading.gd` for price calculations).
  - **characters/** – NPC behavior scripts (e.g. `VillagerAI.gd` for NPC routines).
  - **globals/** – Autoload scripts (singletons like `GameState.gd` for global game state, `Economy.gd` for global economy settings).
- **res://assets/** – Game assets:
  - **sprites/** (2D images), **audio/** (sound files), etc.
- **res://addons/** – Editor plugins and third-party tools:
  - e.g. **Gut** (Godot Unit Test framework) for testing, **Copilot** plugin if used, etc.
- **res://tests/** – Automated test scripts (if using GUT/GdUnit4). Contains test scenes or test GDScripts that validate game logic.
- **Project configuration files**: `project.godot` (project settings), this `AGENTS.md`, `README.md` (player/developer info), etc.

*(AI agents: use the above structure to locate or create files. For example, new UI scenes go in `res://scenes/ui/`, and global scripts go in `res://scripts/globals/`.)*

## Coding Standards
All code is written in **GDScript** (Godot 4.4). Follow these conventions to maintain consistency:
- **Naming:** Use `snake_case` for variables and functions, `PascalCase` for class names and node names:contentReference[oaicite:25]{index=25}:contentReference[oaicite:26]{index=26}. File names are lowercase `snake_case` (e.g. `inventory_manager.gd`). Constants are `ALL_CAPS` with underscores.
- **Scene & Script Setup:** Each `.tscn` scene has a corresponding `.gd` script named the same (e.g. `Shop.tscn` -> `Shop.gd`). The root node name usually matches the scene name (PascalCase). Define `class_name` in scripts when appropriate for easy instancing.
- **GDScript Style:** 4-space indentation; one class per file. Use Godot’s built-in signals for decoupled communication (e.g., an NPC emits `trade_completed` which the `Market.gd` listens to). Include brief comments for any complex algorithm or math. Write Docstrings for functions that are part of the game’s API (especially in singleton classes).
- **Godot 4 Specifics:** Use `await` for asynchronous calls (replacing the old `yield`). Use typed GDScript where possible (e.g. `var gold:int = 0`) for clarity. Prefer built-in Godot types (Arrays, Dictionaries, etc.) and methods. Free nodes with `queue_free()` when removing them. Agents should consult Godot 4.4 documentation for APIs (for instance, using `CharacterBody2D.move_and_slide()` correctly without deprecated parameters).
- **Error Handling:** Use `assert()` in development for critical assumptions. For user-facing errors (e.g. "Not enough gold"), handle gracefully in code (no uncaught exceptions). AI-generated code should include basic checks (null checks, size checks on arrays, etc., as would a careful human coder).
- **Formatting:** We use a GDScript formatter (gdformat) before commits. Ensure code is properly formatted (spacing around `=`, after commas, etc.). No trailing whitespaces. Agents can run `gdformat .` (or the provided format script) to auto-format any generated code.

## AI Assistance Tasks
We leverage AI agents to **automate repetitive or boilerplate tasks** in development:
- **Code Generation:** Agents can create skeleton code for new features. For example, when a new resource type ("Iron") is added to the economy, the agent may generate the GDScript class for it (if needed), update the inventory data structure, and stub out UI elements (following existing patterns).
- **Refactoring:** Agents should help in refactoring when code grows messy. E.g., if `Market.gd` exceeds 500 lines, an agent might be asked to split out price calculation into `Trading.gd`. Maintain logical separation of concerns as per project structure.
- **Bug Fixing:** When tests (or a developer) identify a bug, an agent can propose a fix. Always run the test suite after changes. Agents should aim for minimal fixes and explain them in comments or commit messages.
- **Documentation & Comments:** Agents may generate documentation comments for functions or create/update entries in the `README.md` or in-code docs when new features are added, to keep human developers informed.
- **Asset Pipeline Automation:** Assist with tasks like generating icon sprites via script or updating resource files. *(Example: if we have a JSON file of item data, an AI script could add a new item in the correct format when prompted.)* However, agents **do not** control in-game AI behaviors or make design decisions beyond code automation.

*(Agents: Before performing any task, ensure you understand the relevant part of the codebase. Follow the coding standards above. When in doubt, leave TODO comments for a human to review.)*

## Testing and Verification
We use automated tests to ensure game logic works:
- **Testing Framework:** The project uses **GUT (Godot Unit Tests)** for GDScript unit tests:contentReference[oaicite:27]{index=27} (installed under `res://addons/gut/`) with test scripts in `res://tests/`. Tests cover critical systems like trading calculations, inventory capacity, save/load, etc.
- **Running Tests:** To run all tests, use the Godot headless mode with GUT's command line runner. For example:  
  ```bash
  godot --headless -s addons/gut/gut_cmdln.gd -gdir=res://tests -ginclude_subdirs -gexit
