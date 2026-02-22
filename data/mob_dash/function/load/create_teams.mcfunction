# Create target data

summon marker ~ ~ ~ {Tags:[md_team], CustomName:'{text:"The Redstone Reapers", color:red}', data:{team_id: 1}}
team add red {text:"The Redstone Reapers", color:red}
team modify red color red

summon marker ~ ~ ~ {Tags:[md_team], CustomName:'{text:"The Charged Creepers", color:green}', data:{team_id: 2}}
team add green {text:"The Charged Creepers", color:green}
team modify green color green

summon marker ~ ~ ~ {Tags:[md_team], CustomName:'{text:"The Poisonous Pufferfish", color:yellow}', data:{team_id: 3}}
team add yellow {text:"The Poisonous Pufferfish", color:yellow}
team modify yellow color yellow

summon marker ~ ~ ~ {Tags:[md_team], CustomName:'{text:"The Fearless Phantoms", color:blue}', data:{team_id: 4}}
team add blue {text:"The Fearless Phantoms", color:blue}
team modify blue color blue

summon marker ~ ~ ~ {Tags:[md_team], CustomName:'{text:"The Shooting Shulkers", color:light_purple}', data:{team_id: 5}}
team add purple {text:"The Shooting Shulkers", color:light_purple}
team modify purple color light_purple

summon marker ~ ~ ~ {Tags:[md_team], CustomName:'{text:"The Blistering Blazes", color:gold}', data:{team_id: 6}}
team add gold {text:"The Blistering Blazes", color:gold}
team modify gold color gold

summon marker ~ ~ ~ {Tags:[md_team], CustomName:'{text:"The Dreadful Drowned", color:aqua}', data:{team_id: 7}}
team add aqua {text:"The Dreadful Drowned", color:aqua}
team modify aqua color aqua

summon marker ~ ~ ~ {Tags:[md_team], CustomName:'{text:"The Blackstone Brutes", color:dark_gray}', data:{team_id: 8}}
team add black {text:"The Blackstone Brutes", color:dark_gray}
team modify black color dark_gray

summon marker ~ ~ ~ {Tags:[md_team], CustomName:'{text:"The Viewing Vexes", color:gray, italic:true}', data:{team_id: 9}}
team add gray {text:"The Viewing Vexes", color:gray}
team modify black color gray

execute as @e[distance=0,type=marker,tag=md_team] store result score @s md_team run data get entity @s data.team_id
