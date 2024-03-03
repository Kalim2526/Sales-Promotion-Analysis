-- (Ad_Hoc.Q1.) --->

select distinct p.product_name , f.base_price 
from fact_events f
join dim_products p
on f.product_code = p.product_code 
where f.base_price >500 and f.promo_type = "BOGOF";

 -- -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- --



 -- > (Ad_Hoc.Q2.)----> ----> -- > ----> ----> -- > ----> ----> -- > ----> ----> -- > ----> ---->
select   city , count(store_id) as count_store
from dim_stores 
 group by city
 order by count_store desc;
 
 
 -- -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- --



-- (Ad_Hoc.Q3.) ----> ----> -- > ----> ----> -- > ----> ----> -- > ----> ----> -- > ----> ---->
select c.campaign_name , concat(round((sum(f.base_price * f.`quantity_sold(before_promo)`)/1000000),2)," M") revenue_before_promo , 
concat(round((sum(f.base_price * f.`quantity_sold(after_promo)`)/1000000),2)," M") revenue_after_promo
from  fact_events f
join dim_campaigns c
on f.campaign_id = c.campaign_id
group by c.campaign_name 
order by  revenue_after_promo desc;


 -- -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- --



  -- > (Ad_Hoc.Q4.)----> ----> -- > ----> ----> -- > ----> ----> -- > ----> ----> -- > ----> ---->
  select  p.category 
		
        ,((sum(`quantity_sold(after_promo)`) - sum(`quantity_sold(before_promo)`))/(sum(`quantity_sold(after_promo)`)))*100 as "ISU%"
        ,rank() OVER (ORDER BY ((sum(`quantity_sold(after_promo)`) - sum(`quantity_sold(before_promo)`))/(sum(`quantity_sold(after_promo)`)))*100 desc) AS Rank_Order
 from  fact_events f
 join dim_products p on f.product_code = p.product_code
 join dim_campaigns c   on c.campaign_id = f.campaign_id
 
 where 1=1
 and  upper(c.campaign_name) = 'DIWALI'
 
group by   p.category
			,c.campaign_name
            
order by p.category desc;

 -- -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- --



 -- > (Ad_Hoc.Q5.)----> ----> -- > ----> ----> -- > ----> ----> -- > ----> ----> -- > ----> ---->

select p.product_name , p.category ,
round(sum((f.base_price*f.`quantity_sold(after_promo)`) /
 (select sum(f.base_price*f.`quantity_sold(after_promo)`) from fact_events f) *100),2) IR_Percent
from fact_events f
join dim_products p on f.product_code = p.product_code

group by p.category , p.product_name 
order by IR_Percent desc;

 
  -- -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- --
 
 
 



