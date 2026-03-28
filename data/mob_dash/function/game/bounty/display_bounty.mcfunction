

function mob_dash:game/bounty/setup_sidebar

scoreboard players display name $Bounty md_team_scores_base_ {storage:"mob_dash:data", nbt:Templates.Bounty.BountyText, interpret:true}
scoreboard players display name $Bounty md_team_scores_team1 {storage:"mob_dash:data", nbt:Templates.Bounty.BountyText, interpret:true}
scoreboard players display name $Bounty md_team_scores_team2 {storage:"mob_dash:data", nbt:Templates.Bounty.BountyText, interpret:true}
scoreboard players display name $Bounty md_team_scores_team3 {storage:"mob_dash:data", nbt:Templates.Bounty.BountyText, interpret:true}
scoreboard players display name $Bounty md_team_scores_team4 {storage:"mob_dash:data", nbt:Templates.Bounty.BountyText, interpret:true}
scoreboard players display name $Bounty md_team_scores_team5 {storage:"mob_dash:data", nbt:Templates.Bounty.BountyText, interpret:true}
scoreboard players display name $Bounty md_team_scores_team6 {storage:"mob_dash:data", nbt:Templates.Bounty.BountyText, interpret:true}
scoreboard players display name $Bounty md_team_scores_team7 {storage:"mob_dash:data", nbt:Templates.Bounty.BountyText, interpret:true}
scoreboard players display name $Bounty md_team_scores_team8 {storage:"mob_dash:data", nbt:Templates.Bounty.BountyText, interpret:true}

function mob_dash:game/bounty/calculate_bounty_scores

scoreboard players display numberformat $Bounty md_team_scores_base_ fixed {score: {objective:md_score,        name:"@n[distance=..1,type=marker,tag=md_bounty,tag=md_selected]"},  color:green}
scoreboard players display numberformat $Bounty md_team_scores_team1 fixed {score: {objective:md_bounty_score, name:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=1}]"}, color:green}
scoreboard players display numberformat $Bounty md_team_scores_team2 fixed {score: {objective:md_bounty_score, name:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=2}]"}, color:green}
scoreboard players display numberformat $Bounty md_team_scores_team3 fixed {score: {objective:md_bounty_score, name:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=3}]"}, color:green}
scoreboard players display numberformat $Bounty md_team_scores_team4 fixed {score: {objective:md_bounty_score, name:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=4}]"}, color:green}
scoreboard players display numberformat $Bounty md_team_scores_team5 fixed {score: {objective:md_bounty_score, name:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=5}]"}, color:green}
scoreboard players display numberformat $Bounty md_team_scores_team6 fixed {score: {objective:md_bounty_score, name:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=6}]"}, color:green}
scoreboard players display numberformat $Bounty md_team_scores_team7 fixed {score: {objective:md_bounty_score, name:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=7}]"}, color:green}
scoreboard players display numberformat $Bounty md_team_scores_team8 fixed {score: {objective:md_bounty_score, name:"@n[distance=..1,type=marker,tag=md_team,scores={md_team=8}]"}, color:green}