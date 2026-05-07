tellraw @s [ \
    {text:"Welcome to "}, \
    {text:"Mob Dash!", color:gold}, \
    {text:" version "}, \
    {storage:"mob_dash:data", nbt:Version, interpret:true, color:gold}, \
    {text:" by "}, \
    {text:"slicedlime", underlined:true, color:green, \
        click_event: {action:open_url, url:"https://www.youtube.com/slicedlime"}}, \
    {text:" (with tweaks by ", color:green}, \
    {text:"Hunsinger", underlined:true, color:green, \
        click_event: {action:open_url, url:"https://github.com/HunsingerTheMatist/MobDash"}}, \
    {text:")", color:green} \
]
