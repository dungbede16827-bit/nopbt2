
select * from Drivers
where status = 'AVAILABLE' and trust_score >= 80
order by distance_km ASC, trust_score DESC;
-- asc tăng dần  tài xế đimgứ gần hơn thì đứng trước 
-- desc giảm dần tài xế uy tín cao hơn đứng trước

	