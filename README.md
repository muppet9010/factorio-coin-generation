# factorio-coin-generation

A mod to allow multiple ways to generate coins in game; doing private science research.

![Private research institute](https://thumbs.gfycat.com/BaggyEarlyArabianoryx-size_restricted.gif)

Private research institute
------------

- A facility that takes in science packs and does private research (process) to produce coins. This facility is approximately equal to a science lab in terms of per science pack processing times, module options and cost.
- 2 processing types for private research of science packs:
    - Per science pack: a separate recipe for each science pack giving the packs value in coins. Recipe ingredient quantity and processing times are generated to ensure a fair coin value, rather than allowing heavy skewing due to rounding.
    - Grouped science pack (non space): a recipe requiring 1 of each science pack below space science.
    - Grouped science pack (with space): a recipe requiring 1 of each science pack including space science.
- An option to set the value decrease percentage you get from doing private research. This is to add a premium to coin generation to enable balancing with other coin generation methods and spending mods.
- Science coin value is based on the same system as my other coin related mods:
    - Automation science pack = 1.1
    - Logistic science pack = 2.7
    - Military science pack = 6
    - Chemical science pack = 10
    - Production science pack = 33.8
    - Utility science pack = 37.9
    - Space science pack = 80.4

Biter killing bounty
---------------

- A bounty is paid for the killing of the biters and their bases, with different values for players and turrets.
- The biter & worm coin value is based on enemy health and scales logarithmically to slower increase with further health gain. Small biter is ~1 coin, large is ~4 and a behemoth is ~7 coins. Partial coin values are handled by chance. You can control a multiplier on this.
- Biter nest is a static coin value.
- Option to set turret coin value as a multiplier of player in fractions, i.e. 0.1
- Options to set the coin delivery location for players and turrets separately. Including in the player inventory, on the ground by the killer, by the corpse or in other modded collection points (Prime Intergalactic Delivery payment chest).


Planned Features
------------

- Scheduling regular coin deliveries and optionally use the item delivery pod mod. Started but doesn't feel right options wise so put on hold and hidden in mod.


Muppet Coin Based Mod Collection
------------------

This mod is part of my collection of mods that use the vanilla Factorio coins. They are designed to work together or separately as required. You can also mix with other peoples mods that use vanilla Factorio coins.

- Prime Intergalactic Delivery: a market to buy items for coins.
- Item Delivery Pod: a crashing spaceship that can bring items to the map with an explosive delivery.
- Coin Generation: a mod with a variety of ways for players and streamers to generate/obtain coins.
- Streamlabs RCON Integration: an external tool that lets streamers trigger in game actions from Streamlabs: https://github.com/muppet9010/Streamlabs-Rcon-Integration

A number of my other mods are designed for streamers or have features to make them streamer friendly.


Notes
---------

- Doesn't account for expensive mode.
- Doesn't support modded science packs.