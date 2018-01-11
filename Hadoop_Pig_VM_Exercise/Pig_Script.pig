--posts = LOAD'/home/training/petexchange/posts.tsv' AS 

posts = LOAD'/petsexchange/posts/part-m-0000[03]' AS
(Id:int, 
PostTypeId:int,
AcceptedAnswerId:int,
ParentID:int,
CreationDate:datetime, 
DeletionDate:datetime,
Score:int, 
Viewcount:int, 
OwnerUserId:int,
OwnerDisplayName:chararray,
LastEditorUserId:int,
LastEditorDisplayName:chararray,
LastEditDate:datetime,
LastActivityDate:datetime,
Title:chararray, 
Tags:chararray, 
AnswerCount:int,
CommentCount:int,
FavoriteCount:int,
ClosedDate:datetime,
CommunityOwnedDate:datetime);

origposts = FILTER posts BY PostTypeId == 1;
reorderfields = FOREACH origposts GENERATE Id, CreationDate, Title, Tags, Score, Viewcount;
grouped = GROUP reorderfields ALL;
summarize = FOREACH grouped GENERATE COUNT(reorderfields.Id),SUM(reorderfields.Viewcount);
DUMP summarize;
--STORE totals into '/home/training/petexchange/output/summarize_posts';