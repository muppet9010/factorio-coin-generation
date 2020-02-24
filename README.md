# factorio-coin-generation
A mod to allow multiple ways to generate coins ingame; doing private science research.

Private research institute
------------

- A facility that takes in science packs and does private research (proccess) to produce coins. This facility is approximately equal to a science lab in terms of per science pack processing times and module options.
- 2 processing types for private research of science packs:
    - Per science pack: a seperate recipe for each science pack giving the packs value in coins. Recipe ingredient quantity and processing times are generated to ensure a fair coin value, rather than allowing heavy skewing due to rounding.
    - Grouped science pack: a recipe of 1 of each science pack below space science.
- An option to set the value decrease percentage you get from doing private research. This is to add a premium to coin generation to enable balancing with other coin generation methods and spending mods.
- Science coin value is based on the same system as my other coin related mods:
    - Automation science pack = 1.1
    - Logistic science pack = 2.7
    - Military science pack = 6
    - Chemical science pack = 10
    - Production science pack = 33.8
    - Utility science pack = 37.9
    - Space science pack = 80.4


Planned Features
------------

- killing biters
- scheduling regular coin deliveries.


Notes
---------

- Doesn't account for expensive mode.
- Doesn't explictily support modded science packs.