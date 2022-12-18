use practice;
select * from q6of1;
select * from q6_part2;
with cte_1 as (
select a.PersonID,a.Name,a.Email,a.Score,b.FriendID
from q6of1 a join q6_part2 b on a.PersonID=b.PersonID), cte_2 as (select c.PersonID,c.Name,c.Email,c.Score,c.FriendID,d.Score as friend_score
from cte_1 c join q6of1 d on c.FriendId=d.PersonId)
select Name,PersonID,count(PersonID) as no_of_frnds,sum(friend_score) as total_score from cte_2
group by Name,PersonID
having sum(friend_score) >100
order by PersonID;
