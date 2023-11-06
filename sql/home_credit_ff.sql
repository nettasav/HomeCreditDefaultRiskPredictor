
WITH 

bureau_grouped AS(
SELECT 
SK_ID_CURR,

SUM(CASE WHEN CREDIT_ACTIVE = 'Closed' THEN 1 ELSE 0 END) AS count_CREDIT_ACTIVE_Closed,
SUM(CASE WHEN CREDIT_ACTIVE = 'Active' THEN 1 ELSE 0 END) AS count_CREDIT_ACTIVE_Active,
SUM(CASE WHEN CREDIT_ACTIVE = 'Sold' THEN 1 ELSE 0 END) AS count_CREDIT_ACTIVE_Sold,
SUM(CASE WHEN CREDIT_ACTIVE = 'Bad debt' THEN 1 ELSE 0 END) AS count_CREDIT_ACTIVE_Bad_debt,

SUM(CASE WHEN CREDIT_CURRENCY = 'currency 1' THEN 1 ELSE 0 END) AS count_CREDIT_CURRENCY_currency1,
SUM(CASE WHEN CREDIT_CURRENCY = 'currency 2' THEN 1 ELSE 0 END) AS count_CREDIT_CURRENCY_currency2,
SUM(CASE WHEN CREDIT_CURRENCY = 'currency 3' THEN 1 ELSE 0 END) AS count_CREDIT_CURRENCY_currency3,
SUM(CASE WHEN CREDIT_CURRENCY = 'currency 4' THEN 1 ELSE 0 END) AS count_CREDIT_CURRENCY_currency4,

MAX(DAYS_CREDIT) AS max_DAYS_CREDIT,

MIN(CASE WHEN CREDIT_ACTIVE = 'Active' THEN DAYS_CREDIT_ENDDATE END) AS min_DAYS_CREDIT_ENDDATE_Active,

MAX(DAYS_ENDDATE_FACT) AS max_DAYS_ENDDATE_FACT,

MAX(AMT_CREDIT_MAX_OVERDUE) AS max_AMT_CREDIT_MAX_OVERDUE,

MAX(CNT_CREDIT_PROLONG) AS max_CNT_CREDIT_PROLONG,

AVG(AMT_CREDIT_SUM) AS avg_AMT_CREDIT_SUM,

AVG(AMT_CREDIT_SUM_DEBT) AS avg_AMT_CREDIT_SUM_DEBT,

AVG(AMT_CREDIT_SUM_LIMIT) AS avg_AMT_CREDIT_SUM_LIMIT,

AVG(AMT_CREDIT_SUM_OVERDUE) AS avg_AMT_CREDIT_SUM_OVERDUE,

SUM(CASE WHEN CREDIT_TYPE = 'Consumer credit' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Consumer_credit,
SUM(CASE WHEN CREDIT_TYPE = 'Credit card' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Creditc_card,
SUM(CASE WHEN CREDIT_TYPE = 'Mortgage' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Mortgage,
SUM(CASE WHEN CREDIT_TYPE = 'Car loan' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Car_loan,
SUM(CASE WHEN CREDIT_TYPE = 'Microloan' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Microloan,
SUM(CASE WHEN CREDIT_TYPE = 'Loan for working capital replenishment' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Loan_for_working_capital_replenishment,
SUM(CASE WHEN CREDIT_TYPE = 'Loan for business development' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Loan_for_business_development,
SUM(CASE WHEN CREDIT_TYPE = 'Real estate loan' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Real_estate_loan,
SUM(CASE WHEN CREDIT_TYPE = 'Unknown type of loan' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Unknown_type_of_loan,
SUM(CASE WHEN CREDIT_TYPE = 'Another type of loan' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Another_type_of_loan,
SUM(CASE WHEN CREDIT_TYPE = 'Cash loan (non-earmarked)' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Cash_loan,
SUM(CASE WHEN CREDIT_TYPE = 'Loan for the purchase of equipment' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_purchase_of_equipment,
SUM(CASE WHEN CREDIT_TYPE = 'Mobile operator loan' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Mobile_operator_loan,
SUM(CASE WHEN CREDIT_TYPE = 'Interbank credit' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_Interbank_credit,
SUM(CASE WHEN CREDIT_TYPE = 'Loan for purchase of shares (margin lending)' THEN 1 ELSE 0 END) AS count_CREDIT_TYPE_purchase_of_shares,

MAX(DAYS_CREDIT_UPDATE) AS max_DAYS_CREDIT_UPDATE

FROM dbo.bureau
GROUP BY SK_ID_CURR
--ORDER BY SK_ID_CURR
),


credit_card_balance_grouped AS (
SELECT
SK_ID_CURR,
 COUNT(MONTHS_BALANCE) AS count_MONTHS_BALANCE
, AVG(AMT_BALANCE) AS avg_AMT_BALANCE
, AVG(AMT_CREDIT_LIMIT_ACTUAL) AS avg_AMT_CREDIT_LIMIT_ACTUAL
,AVG(AMT_DRAWINGS_ATM_CURRENT) AS avg_AMT_DRAWINGS_ATM_CURRENT
,AVG(AMT_DRAWINGS_CURRENT) AS avg_AMT_DRAWINGS_CURRENT
,AVG(AMT_DRAWINGS_OTHER_CURRENT) AS avg_AMT_DRAWINGS_OTHER_CURRENT
,AVG(AMT_DRAWINGS_POS_CURRENT) AS avg_AMT_DRAWINGS_POS_CURRENT
,AVG(AMT_INST_MIN_REGULARITY) AS avg_AMT_INST_MIN_REGULARITY
,AVG(AMT_PAYMENT_CURRENT) AS avg_AMT_PAYMENT_CURRENT
,AVG(AMT_PAYMENT_TOTAL_CURRENT) AS avg_AMT_PAYMENT_TOTAL_CURRENT
,AVG(AMT_RECEIVABLE_PRINCIPAL) AS avg_AMT_RECEIVABLE_PRINCIPAL
,AVG(AMT_RECIVABLE)  AS avg_AMT_RECIVABLE
,AVG(AMT_TOTAL_RECEIVABLE) AS avg_AMT_TOTAL_RECEIVABLE
, SUM(CNT_DRAWINGS_ATM_CURRENT) AS sum_CNT_DRAWINGS_ATM_CURRENT
, SUM(CNT_DRAWINGS_CURRENT) AS sum_CNT_DRAWINGS_CURRENT
, SUM(CNT_DRAWINGS_OTHER_CURRENT) AS sum_CNT_DRAWINGS_OTHER_CURRENT
, SUM(CNT_DRAWINGS_POS_CURRENT) AS sum_CNT_DRAWINGS_POS_CURRENT

FROM dbo.credit_card_balance
GROUP BY SK_ID_CURR

),

installments_payments_grouped AS (
SELECT 
SK_ID_CURR
,MAX(DAYS_ENTRY_PAYMENT - DAYS_INSTALMENT) AS max_num_days_of_payment_late
,MAX(AMT_PAYMENT - AMT_INSTALMENT) AS max_Unpaid_balance
,COUNT(AMT_PAYMENT - AMT_INSTALMENT) AS num_of_installments_didnt_pay_all_amt

FROM dbo.installments_payments
GROUP BY SK_ID_CURR
),

POS_CASH_balance_grouped AS (
SELECT 
SK_ID_CURR
, COUNT(MONTHS_BALANCE) AS count_MONTHS_BALANCE
, SUM(CASE WHEN MONTHS_BALANCE = MAX_MONTHS_BALANCE THEN CNT_INSTALMENT END) AS min_CNT_INSTALMENT
, sum(CASE WHEN MONTHS_BALANCE = MAX_MONTHS_BALANCE THEN CNT_INSTALMENT_FUTURE END) AS min_CNT_INSTALMENT_FUTURE
, AVG(SK_DPD) AS avg_SK_DPD
,AVG(SK_DPD_DEF) AS avg_SK_DPD_DEF
FROM (
	SELECT 
		SK_ID_CURR,
		MONTHS_BALANCE,
		MAX(MONTHS_BALANCE) OVER (PARTITION BY SK_ID_CURR) AS MAX_MONTHS_BALANCE,
		CNT_INSTALMENT,
		CNT_INSTALMENT_FUTURE,
		SK_DPD,
		SK_DPD_DEF
	FROM dbo.POS_CASH_balance
) AS m

GROUP BY SK_ID_CURR
),

previous_application_grouped AS (
SELECT 
	SK_ID_CURR,
	count(SK_ID_PREV) as count_pa_SK_ID_PREV,
	sum(case when NAME_CONTRACT_TYPE='Cash loans' then 1 else 0 end) as count_NAME_CONTRACT_TYPE_Cash_loans,
	sum(case when NAME_CONTRACT_TYPE='Consumer loans' then 1 else 0 end) as count_NAME_CONTRACT_TYPE_Consumer_loans,
	avg(AMT_APPLICATION) as avg_AMT_APPLICATION,
	avg(AMT_CREDIT) as avg_AMT_CREDIT,
	avg(AMT_DOWN_PAYMENT) as avg_AMT_DOWN_PAYMENT,
	avg(AMT_GOODS_PRICE) as avg_AMT_GOODS_PRICE,
--      mode(WEEKDAY_APPR_PROCESS_START) as WEEKDAY_APPR_PROCESS_START,
--      mode(HOUR_APPR_PROCESS_START) as mode_HOUR_APPR_PROCESS_START.
	avg(DAYS_DECISION) as avg_DAYS_DECISION,
	avg(RATE_DOWN_PAYMENT) as avg_RATE_DOWN_PAYMENT,
	sum(case when NAME_CASH_LOAN_PURPOSE='XAP' then 1 else 0 end) as count_NAME_CASH_LOAN_PURPOSE_XAP,
	sum(case when NAME_CASH_LOAN_PURPOSE='XNA' then 1 else 0 end) as count_NAME_CASH_LOAN_PURPOSE_XNA,
	sum(case when NAME_CONTRACT_STATUS='Approved' then 1 else 0 end) as count_NAME_CONTRACT_STATUS_Approved,
	sum(case when NAME_CONTRACT_STATUS='Canceled' then 1 else 0 end) as count_NAME_CONTRACT_STATUS_Canceled,
	sum(case when NAME_PAYMENT_TYPE='Cash through the bank' then 1 else 0 end) as count_NAME_PAYMENT_TYPE_Cash_through_the_bank,
	sum(case when NAME_PAYMENT_TYPE='XNA' then 1 else 0 end) as count_NAME_PAYMENT_TYPE_XNA,
	sum(case when CODE_REJECT_REASON='XAP' then 1 else 0 end) as count_CODE_REJECT_REASON_XAP,
	sum(case when CODE_REJECT_REASON='HC' then 1 else 0 end) as count_CODE_REJECT_REASON_HC,
	sum(case when NAME_PORTFOLIO='POS' then 1 else 0 end) as count_NAME_PORTFOLIO_POS,
	sum(case when NAME_PORTFOLIO='Cash' then 1 else 0 end) as count_NAME_PORTFOLIO_Cash,
	sum(case when NAME_YIELD_GROUP='XNA' then 1 else 0 end) as count_NAME_YIELD_GROUP_XNA,
	sum(case when NAME_YIELD_GROUP='middle' then 1 else 0 end) as count_NAME_YIELD_GROUP_middle,
	avg(NFLAG_INSURED_ON_APPROVAL) as avg_NFLAG_INSURED_ON_APPROVAL,
	max(case when DAYS_TERMINATION = 365243 then NULL else DAYS_TERMINATION end) as max_DAYS_TERMINATION,
	min(case when DAYS_TERMINATION = 365243 then NULL else DAYS_TERMINATION end) as min_DAYS_TERMINATION
	--max(DAYS_TERMINATION) as max_DAYS_TERMINATION,
	--min(DAYS_TERMINATION) as min_DAYS_TERMINATION


FROM dbo.previous_application
group by SK_ID_CURR

)

SELECT 
app_t.*,
b.count_CREDIT_ACTIVE_Closed,
b.count_CREDIT_ACTIVE_Active,
b.count_CREDIT_ACTIVE_Sold,
b.count_CREDIT_ACTIVE_Bad_debt,

b.count_CREDIT_CURRENCY_currency1,
b.count_CREDIT_CURRENCY_currency2,
b.count_CREDIT_CURRENCY_currency3,
b.count_CREDIT_CURRENCY_currency4,

b.max_DAYS_CREDIT,

b.min_DAYS_CREDIT_ENDDATE_Active,

b.max_DAYS_ENDDATE_FACT,

b.max_AMT_CREDIT_MAX_OVERDUE,
b.max_CNT_CREDIT_PROLONG,
b.avg_AMT_CREDIT_SUM,

b.avg_AMT_CREDIT_SUM_DEBT,

b.avg_AMT_CREDIT_SUM_LIMIT,

b.avg_AMT_CREDIT_SUM_OVERDUE,

b.count_CREDIT_TYPE_Consumer_credit,
b.count_CREDIT_TYPE_Creditc_card,
b.count_CREDIT_TYPE_Mortgage,
b.count_CREDIT_TYPE_Car_loan,
b.count_CREDIT_TYPE_Microloan,
b.count_CREDIT_TYPE_Loan_for_working_capital_replenishment,
b.count_CREDIT_TYPE_Loan_for_business_development,
b.count_CREDIT_TYPE_Real_estate_loan,
b.count_CREDIT_TYPE_Unknown_type_of_loan,
b.count_CREDIT_TYPE_Another_type_of_loan,
b.count_CREDIT_TYPE_Cash_loan,
b.count_CREDIT_TYPE_purchase_of_equipment,
b.count_CREDIT_TYPE_Mobile_operator_loan,
b.count_CREDIT_TYPE_Interbank_credit,
b.count_CREDIT_TYPE_purchase_of_shares,

b.max_DAYS_CREDIT_UPDATE

,c.count_MONTHS_BALANCE
,c.avg_AMT_BALANCE
,c.avg_AMT_CREDIT_LIMIT_ACTUAL
,c.avg_AMT_DRAWINGS_ATM_CURRENT
,c.avg_AMT_DRAWINGS_CURRENT
,c.avg_AMT_DRAWINGS_OTHER_CURRENT
,c.avg_AMT_DRAWINGS_POS_CURRENT
,c.avg_AMT_INST_MIN_REGULARITY
,c.avg_AMT_PAYMENT_CURRENT
,c.avg_AMT_PAYMENT_TOTAL_CURRENT
,c.avg_AMT_RECEIVABLE_PRINCIPAL
,c.avg_AMT_RECIVABLE
,c.avg_AMT_TOTAL_RECEIVABLE
,c.sum_CNT_DRAWINGS_ATM_CURRENT
,c.sum_CNT_DRAWINGS_CURRENT
,c.sum_CNT_DRAWINGS_OTHER_CURRENT
,c.sum_CNT_DRAWINGS_POS_CURRENT 

,i.max_num_days_of_payment_late
,i.max_Unpaid_balance
,i.num_of_installments_didnt_pay_all_amt

, pc.count_MONTHS_BALANCE
,  pc.min_CNT_INSTALMENT
, pc.min_CNT_INSTALMENT_FUTURE
, pc.avg_SK_DPD
, pc.avg_SK_DPD_DEF

,pa.count_pa_SK_ID_PREV,
pa.count_NAME_CONTRACT_TYPE_Cash_loans,
pa.count_NAME_CONTRACT_TYPE_Consumer_loans,
pa.avg_AMT_APPLICATION,
pa.avg_AMT_CREDIT,
pa.avg_AMT_DOWN_PAYMENT,
pa.avg_AMT_GOODS_PRICE,
pa.avg_DAYS_DECISION,
pa.avg_RATE_DOWN_PAYMENT,
pa.count_NAME_CASH_LOAN_PURPOSE_XAP,
pa.count_NAME_CASH_LOAN_PURPOSE_XNA,
pa.count_NAME_CONTRACT_STATUS_Approved,
pa.count_NAME_CONTRACT_STATUS_Canceled,
pa.count_NAME_PAYMENT_TYPE_Cash_through_the_bank,
pa.count_NAME_PAYMENT_TYPE_XNA,
pa.count_CODE_REJECT_REASON_XAP,
pa.count_CODE_REJECT_REASON_HC,
pa.count_NAME_PORTFOLIO_POS,
pa.count_NAME_PORTFOLIO_Cash,
pa.count_NAME_YIELD_GROUP_XNA,
pa.count_NAME_YIELD_GROUP_middle,
pa.avg_NFLAG_INSURED_ON_APPROVAL,
pa.max_DAYS_TERMINATION,
pa.min_DAYS_TERMINATION



FROM dbo.application_train app_t

LEFT OUTER JOIN bureau_grouped b
ON app_t.SK_ID_CURR = b.SK_ID_CURR

LEFT OUTER JOIN credit_card_balance_grouped c
ON app_t.SK_ID_CURR= c.SK_ID_CURR

LEFT OUTER JOIN installments_payments_grouped i
ON app_t.SK_ID_CURR = i.SK_ID_CURR

LEFT OUTER JOIN POS_CASH_balance_grouped pc
ON app_t.SK_ID_CURR = pc.SK_ID_CURR

LEFT OUTER JOIN previous_application_grouped pa
ON app_t.SK_ID_CURR = pa.SK_ID_CURR

--order by app_t.SK_ID_CURR