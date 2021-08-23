drop table tbl_product;

create table tbl_product(
p_code char(4) not null primary key,
p_name varchar2(20),
p_size varchar2(40),
p_type varchar2(20),
p_price number(7)
);

desc tbl_product; -- Run Sql에서 구조생성확인

insert into tbl_product values ('A001', 'A-1형 소형박스', '100 X 110 X 50', 'A골판지', '5000');
insert into tbl_product values ('A002', 'A-2형 소형박스', '100 X 110 X 70', 'A골판지', '6000');
insert into tbl_product values ('A003', 'A-3형 소형박스', '100 X 110 X 100', 'A골판지', '7000');
insert into tbl_product values ('B001', 'B-1형 중형박스', '150 X 130 X 50', 'B골판지', '10000');
insert into tbl_product values ('B002', 'B-2형 중형박스', '150 X 130 X 70', 'B골판지', '11000');
insert into tbl_product values ('B003', 'B-3형 중형박스', '150 X 130 X 100', 'B골판지', '13000');
insert into tbl_product values ('C001', 'C-1형 대형박스', '180 X 150 X 50', 'C골판지', '15000');
insert into tbl_product values ('C002', 'C-2형 대형박스', '180 X 150 X 70', 'C골판지', '17000');
insert into tbl_product values ('C003', 'C-3형 대형박스', '180 X 150 X 100', 'C골판지', '20000');

select * from tbl_product; -- insert확인

drop tbl_worklist;

create table tbl_worklist(
w_workno char(8) not null primary key,
p_code char(4),
w_quantity number(5),
w_workdate date
);

desc tbl_worklist; -- Run Sql에서 구조생성확인

insert into tbl_worklist values ('20190001', 'A001', '100', '19/11/01');
insert into tbl_worklist values ('20190002', 'A002', '150', '19/11/01');
insert into tbl_worklist values ('20190003', 'A003', '200', '19/11/01');
insert into tbl_worklist values ('20190004', 'B001', '250', '19/11/02');
insert into tbl_worklist values ('20190005', 'B002', '100', '19/11/02');
insert into tbl_worklist values ('20190006', 'B003', '150', '19/11/02');
insert into tbl_worklist values ('20190007', 'A001', '100', '19/11/03');
insert into tbl_worklist values ('20190008', 'A002', '150', '19/11/03');
insert into tbl_worklist values ('20190009', 'A003', '200', '19/11/03');

select * from tbl_worklist; -- insert확인

drop table tbl_process;

create table tbl_process(
w_workno char(8) not null primary key,
p_p1 char(1),
p_p2 char(1),
p_p3 char(1),
p_p4 char(1),
p_p5 char(1),
p_p6 char(1),
w_lastdate char(8),
w_lasttime char(4)
);

desc tbl_process; -- Run Sql에서 구조생성확인

insert into tbl_process values ('20190001', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', '20191001', '0930');
insert into tbl_process values ('20190002', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', '20191001', '1030');
insert into tbl_process values ('20190003', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', '20191001', '1130');
insert into tbl_process values ('20190004', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', '20191002', '1330');
insert into tbl_process values ('20190005', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', '20191002', '1430');
insert into tbl_process values ('20190006', 'Y', 'Y', 'Y', 'Y', 'Y', 'N', '20191002', '1530');
insert into tbl_process values ('20190007', 'Y', 'Y', 'Y', 'Y', 'N', 'N', '20191003', '1630');
insert into tbl_process values ('20190008', 'Y', 'Y', 'Y', 'Y', 'N', 'N', '20191003', '1730');

select * from tbl_process; -- insert확인

--select.jsp
select p_code, p_name
--substr(p_name,1,4)||substr(p_name,6,4) as p_name, -- 방법1.띄어쓰기 돼있는거 같으므로 주석처리
--concat(substr(p_name,1,4),substr(p_name,6,4)) as p_name, -- 방법2.띄어쓰기 돼있는거같으므로 주석처리
p_size, p_type, 
to_char(p_price, 'L999,999,999') as p_price
from tbl_product;

--select2.jsp
select substr(w_workno,1,4)||'-'||substr(w_workno,5,4) as w_workno, 
p_code, p_name, p_size, p_type, w_quantity, 
to_char(w_workdate, 'yyyy-mm-dd') as w_workdate 
from tbl_product natural join tbl_worklist;

--select3.jsp(방법-1)
--★tbl_process에 작업공정등록이 되므로 w_workno는 tbl_process(pc)것을 가져와야한다.
--w.w_workno를 쓴다면 빈값이 나옴
select substr(pc.w_workno,1,4)||'-'||substr(pc.w_workno,5,4) as w_workno, 
--p_code는 product와 worklist에 중복값이 있으므로 어디것을 가져올지 적어줘야함. 둘다 null로 돼있으므로 아무거나 가져와도 무방하다.
w.p_code, p_name,
decode(p_p1, 'Y', '완료', 'N', '~', '') as p_p1, 
decode(p_p2, 'Y', '완료', 'N', '~', '') as p_p2, 
decode(p_p3, 'Y', '완료', 'N', '~', '') as p_p3, 
decode(p_p4, 'Y', '완료', 'N', '~', '') as p_p4, 
decode(p_p5, 'Y', '완료', 'N', '~', '') as p_p5, 
decode(p_p6, 'Y', '완료', 'N', '~', '') as p_p6, 
--to_char(수나 날짜, '형식') 사용못하는 이유 : w_lastdate는 문자(char)이므로 사용불가
--방법(1) substr사용
--substr(w_lastdate,1,4)||'-'||substr(w_lastdate,5,2)||'-'||substr(w_lastdate,7,2) as w_lastdate, 
--방법(2) to_date로 date로 변환하여 사용
to_char(to_date(w_lastdate),'yyyy-mm-dd') as w_lastdate, 
substr(w_lasttime,1,2)||':'||substr(w_lasttime,3,2) as w_lasttime
from tbl_process pc left outer join tbl_worklist w
on pc.w_workno = w.w_workno
left outer join tbl_product pd
on w.p_code = pd.p_code
order by 1;

--★★select3.jsp(방법-2) 간단.
--몰랐던것들
--to_date에도 바로 '형식'을 지정할수 있었다.
--시간도 형식을 지정하는게 더 간단했다.
--서브쿼리로 쓰지않고 ,를 사용해 outer조인으로 쭉 나열 후 where절에 (+)로 간단히 표시할 수 있었다.
select substr(pc.w_workno,1,4)||'-'||substr(pc.w_workno,5,4) as w_workno, 
w.p_code, p_name, 
decode(p_p1, 'Y', '완료', 'N', '~', '') as p_p1, 
decode(p_p2, 'Y', '완료', 'N', '~', '') as p_p2, 
decode(p_p3, 'Y', '완료', 'N', '~', '') as p_p3, 
decode(p_p4, 'Y', '완료', 'N', '~', '') as p_p4, 
decode(p_p5, 'Y', '완료', 'N', '~', '') as p_p5, 
decode(p_p6, 'Y', '완료', 'N', '~', '') as p_p6, 
to_char(to_date(w_lastdate,'yyyy-mm-dd'),'yyyy-mm-dd') as w_lastdate, 
to_char(to_date(w_lasttime,'HH24:MI'),'HH24:MI') as w_lasttime
from tbl_process pc, tbl_worklist w, tbl_product pd
where pc.w_workno = w.w_workno(+) and w.p_code = pd.p_code(+) -- 조인조건. (+)가 없는곳의 결과 모두 출력 후 없는값은 (+)가 있는곳의 값(null)으로출력
order by 1;

--함수 정리(선생님)
--1. to_char(수 또는 날짜, '문자형식') : 수 또는 날짜를 '문자'로 변환
create table to_char_test(
testdate date, -- 날짜
testnum number(10) -- 숫자
);

insert into to_char_test values ('19/10/10', 20191010);

select * from to_char_test; -- date형식이므로 시:분:초까지 나옴. 둘다 'yyyy-mm-dd'형식으로 출력하기

select to_char(testdate, 'yyyy-mm-dd') as testdate, -- 날짜 -> 문자
--to_char(testnum, 'yyyy-mm-dd') as testnum -- 수 -> 문자 --★단순 수로 이루어져있어 날짜형식인식못함. 오류
to_char(to_date(testnum,'yyyymmdd'), 'yyyy-mm-dd') as testnum -- 수 -> 날짜 -> 문자
from to_char_test;

select to_char(testdate, 'yyyy-mm-dd') as testdate, -- 날짜 -> 문자
to_char(testnum, 'L999,999,999') as testnum, -- 수 -> 문자 --★단순 수로 이루어져있어 날짜형식이 아닌 단위형식으로 사용할 수 있음. L:지역통화 달러를 표시하려면 $
to_char(testnum, 'L000,000,000') as testnum, -- 9로 했을경우 넘어가는 자리의 수는 표시안하고 0으로하면 0으로 표시함. 
--											ex)값이 1000이라면 999,999로하면 1,000 
--															000,000으로하면 001,000
to_char(testnum, 'L999,999,999.99') as testnum,
to_char(testnum, 'L000,000,000.00') as testnum,
-- 소수점은 9로적으나 0으로적으나 둘다 0으로표시
to_char(testnum, 'L9999999.99') as testnum, -- 자릿수가 맞지않으면 #########로 표현됨(20191010은 8자리나 .앞의 자릿수가 7개이므로 ####...)
to_char(12345.678, 'L9999999.99') as testnum 
-- 자릿수가 맞지않으면 #########로 표현됨(12345는 5자리나 .앞의 자리수가 5자리보다 크므로 표현되고 소수셋째자리에서 반올림하여 둘째자리까지 표현
-- 소수점 9로적으나 0으로적으나 똑같이 셋째자리에서 반올림하여 둘째자리까지 표현
from to_char_test;