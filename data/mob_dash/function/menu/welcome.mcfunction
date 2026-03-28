tellraw @s [ \
    {text:"Welcome to "}, \
    {text:"Mob Dash!", color:gold}, \
    {text:" version "}, \
    {storage:"mob_dash:data", nbt:Version, color:gold}, \
    {text:" by "}, \
    {text:"slicedlime (with tweaks by Hunsinger)", color:green, \
        click_event: {action:open_url, url:"https://www.youtube.com/slicedlime"}} \
]