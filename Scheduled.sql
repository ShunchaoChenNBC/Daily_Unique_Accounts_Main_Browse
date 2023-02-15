
with Deep_Link as (select 
current_date("America/New_York")-1 as Dates,
count(distinct adobe_tracking_id) as Deep_Link_Accounts
FROM 
`nbcu-ds-prod-001.PeacockDataMartSilver.SILVER_VIDEO`
where adobe_date = current_date("America/New_York")-1 and deeplink_flag is not null),
Total as (select 
current_date("America/New_York")-1 as Dates,
count(distinct adobe_tracking_id) as Total_Accounts
FROM 
`nbcu-ds-prod-001.PeacockDataMartSilver.SILVER_VIDEO`
where adobe_date = current_date("America/New_York")-1)


select T.Dates, T.Total_Accounts, D.Deep_Link_Accounts,M.Min_Num_Accounts_on_Main_Browse
from Total T
left join Deep_Link D on D.Dates = T.Dates
left join 
(select D.Dates, 
T.Total_Accounts - D.Deep_Link_Accounts as Min_Num_Accounts_on_Main_Browse
from Deep_Link as D, Total as T) M on M.Dates = D.Dates;

