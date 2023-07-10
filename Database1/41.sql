    --You are tasked by the United States Department Of Health And Human Services With creating a Body Mass Index (BMI) calculator.
    --You will be given a weight In pounds (lb) And a height In feet (ft) And inches (In) And must output the users BMI.
    --The output must be rounded To the nearest one tenth.
    --Additionally, the user should be informed of their weight status given the following categories associated with BMI ranges
    --Below 18.5 "Underweight"
    --18.5 - 24.9: "Normal"
    --25.0 - 29.9: "Overweight"
    --30.0 And Above: "Obese"
    --The weight status Is defined after rounding. A BMI calculation Of 29.99 would be considered "Obese".
    --There are 12 inches In a foot.
    --The formula For BMI Is: 703 * weight (lb) / [height (in)]^2
    --Example:
    --weight = 150lbs
    --height = 5ft 5in
    --703 * [150 ÷ (5 * 12 + 5)^2] = 25.0
    --Their weight status Is "Overweight"
    --Input
    --Line 1: An integer representing the weight of the user in pounds.
    --Line 2: Two space separated integers representing the height Of the user In feet And inches.
    --Output
    --Line 1: The BMI Of the user rounded To the nearest tenth.
    --Line 2: The string representing the Weight Status of the user as defined above. "Underweight", "Normal", "Overweight", Or "Obese"
    --Constraints
    --0 < weight < 1000
    --1 <= height ft <= 9
    --0 <= height in < 12
    --Example
    --Input
    --150
    --5 5
    --Output
    --25.0
    --Overweight

    --create table bmi(
    --    weight_ int,
    --    feet int,
    --    inches int
    --)
    --insert into bmi values (120,5,9),(450,10,10), (450,10,10), (150,5,5), (300,10,10),(300,5,5),(150,10,10)
    with q1 as(
    select  CAST(ROUND(703.0 *(weight_ / POWER((feet * 12.0) + inches,2)),1) as decimal(18,1)) as bmi,* from bmi
    )
    select case
    when bmi>=30
    then 'Obese'
    when bmi>=25
    then 'Overweight'
    when bmi>=18.5
    then 'Normal'
    else 'Underweight'
    end as weight_status,
    * from q1;