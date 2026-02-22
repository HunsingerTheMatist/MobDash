# Display the action bar

# Only needs to be displayed every 40 ticks unless invalidated elsewhere
scoreboard players set $ActionBarTick md_state 40

# Case for 1, 2, or 3 selected mobs
execute if score $TargetCount md_state matches 1 run return run title @a actionbar \
[\
    {text:"Target: ", color:gold}, \
    {storage:"mob_dash:data", nbt:ActionBarTarget1, interpret:true, color:gold} \
]

execute if score $TargetCount md_state matches 2 run return run title @a actionbar \
[\
    {text:"Targets: ", color:gold}, \
    {storage:"mob_dash:data", nbt:ActionBarTarget1, interpret:true, color:gold}, \
    {text:", ", color:gold}, \
    {storage:"mob_dash:data", nbt:ActionBarTarget2, interpret:true, color:gold}, \
]

title @a actionbar \
[\
    {text:"Targets: ", color:gold}, \
    {storage:"mob_dash:data", nbt:ActionBarTarget1, interpret:true, color:gold}, \
    {text:", ", color:gold}, \
    {storage:"mob_dash:data", nbt:ActionBarTarget2, interpret:true, color:gold}, \
    {text:", ", color:gold}, \
    {storage:"mob_dash:data", nbt:ActionBarTarget3, interpret:true, color:gold}, \
]