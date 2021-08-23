<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>(과정평가형 정보처리산업기사)스마트 공장 공정관리 프로그램 ver 2019-09</title>
</head>
<body>
<%@ include file = "header.jsp" %>
	<section>
		<div>
			<h2>작업공정조회</h2>
		</div>
		<table border="1" width = "90%" style = "margin : 0 auto;">
			<tr>
				<th>작업지시번호</th>
				<th>제품코드</th>
				<th>제품명</th>
				<th>준비</th>
				<th>인쇄</th>
				<th>코딩</th>
				<th>합지</th>
				<th>접합</th>
				<th>포장</th>
				<th>최종공정일자</th>
				<th>최종공정시간</th>
			</tr>
			<%
			// 아래 표현식 값가져오는코드에 컬럼명으로 가져오는것이 아니기때문에 각 값의 별칭 생략함
			sql += "select substr(pc.w_workno,1,4)||'-'||substr(pc.w_workno,5,4), ";
			sql += " w.p_code, p_name, ";
			sql += " decode(p_p1, 'Y', '완료', 'N', '~'), ";
			sql += " decode(p_p2, 'Y', '완료', 'N', '~'), ";
			sql += " decode(p_p3, 'Y', '완료', 'N', '~'), ";
			sql += " decode(p_p4, 'Y', '완료', 'N', '~'), ";
			sql += " decode(p_p5, 'Y', '완료', 'N', '~'), ";
			sql += " decode(p_p6, 'Y', '완료', 'N', '~'), ";
			sql += " to_char(to_date(w_lastdate,'yyyy-mm-dd'),'yyyy-mm-dd'), ";
			sql += " to_char(to_date(w_lasttime,'HH24:MI'),'HH24:MI')";
			sql += " from tbl_process pc, tbl_worklist w, tbl_product pd";
			sql += " where pc.w_workno = w.w_workno(+) and w.p_code = pd.p_code(+)";
			sql += " order by 1";
				
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
			%>
			<tr align="center">
			<!-- 아래코드는 표현식 : 변수, 반환값이 있는 메서드를 넣을 수 있다. -->
			<!-- ★null값으로 출력하지않고 빈값으로 넣기위해 조건연산자 사용 -->
				<td><%=rs.getString(1) != null?rs.getString(1):"" %></td> <!-- 표현식 안의 조건연산자. null이 아니면 값을, null이면 ""을 -->
				<td><%=rs.getString(2) != null?rs.getString(2):"" %></td>
				<td><%=rs.getString(3) != null?rs.getString(3):"" %></td>
				<td><%=rs.getString(4) != null?rs.getString(4):"" %></td>
				<td><%=rs.getString(5) != null?rs.getString(5):"" %></td>
				<td><%=rs.getString(6) != null?rs.getString(6):"" %></td>
				<td><%=rs.getString(7) != null?rs.getString(7):"" %></td>
				<td><%=rs.getString(8) != null?rs.getString(8):"" %></td>
				<td><%=rs.getString(9) != null?rs.getString(9):"" %></td>
				<td><%=rs.getString(10) != null?rs.getString(10):"" %></td>
				<td><%=rs.getString(11) != null?rs.getString(11):"" %></td>
			</tr>
			<%
				}
			%>
		</table>
	</section>
<%@ include file = "footer.jsp" %>
</body>
</html>