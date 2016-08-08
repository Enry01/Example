<%@page import="ircmsoft.ConnectDB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>ИРЦМ</title>
		
		<link href="css/ui-lightness/jquery-ui-1.10.4.custom.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<link href="css/tableStyle.css" rel="stylesheet">
		<script src="js/jquery-1.10.2.js"></script>
		<script src="js/jquery-ui-1.10.4.custom.js"></script>
	
		<script type="text/javascript">
			$(document).ready(function(){
        		$('#t1').click(
            		function(){
                 		$('.ui-tabs').css('width', '');
            		}
         		);
         		$('#t2').click(
            		function(){
            	 		$('.ui-tabs').css('width', '100%');
            		}
         		);
    		});
    
			function validate_form()
			{
				var valid = true;
				var val = -1;
				var sel = document.getElementsByName("sel");
				for (var i = 0; i < sel.length; i++) {
    				if (sel[i].checked)
       				{
        				val = sel[i].value;
       				}
				}
				if (val < 0) {
					alert("Необходимо выбрать проект");
					valid = false;
				}
				else {
					document.form_journal.action = "index";
				}
	   
   	 			return valid;
			}
	
			$(document).ready(function() {
   	 			$('#maintable tr:even').css('background-color','#E8E8E8');

			});

			$(function() {
				$("#set").buttonset();
				$("input:submit").button();
				$("input:button").button();
				$( "#tabs" ).tabs();
				$( "#dialog" ).dialog({
					autoOpen: false,
					width: 760
				});

				$("#show-dialog").click(function( event ) {
		   			var mass = [];	
		   			var len = $('td input[name=sel]:checked').parent('td').parent('tr').children('td').length;
		   			for(var i = 2; i < len; i++) {
		    			mass[i - 2] = $('td input[name=sel]:checked').parent('td').parent('tr').children('td:eq(' + i + ')').text();
		   			}
					$('#nameD').val(mass[0]);
					$('#descD').val(mass[1]);
					$('#envD').val(mass[2]);
					$('#pathD').val(mass[3]);
					$('#autD').val(mass[4]);
					$('#devD').val(mass[5]);
					$('#subD').val(mass[6]);
					$('#usedD').val(mass[7]);
					$('#servD').val(mass[8]);
					$('#techD').val(mass[9]);
			
					$('#statusD').find('option:contains("' + mass[10] + '")').attr('selected', 'selected');
			
					var rowId = $('td input[name=sel]:checked').val();
					$('#rowId').val(rowId);
					if (validate_form() == true) {
            			$("#dialog").dialog("open");
						event.preventDefault();
					}
				});
			});
		</script>

		<style>
			body{
				font: 75% "Trebuchet MS", sans-serif;
				margin: 30px;
			}
			.demoHeaders {
				margin-top: 2em;
			}
			#dialog-link {
				padding: .4em 1em .4em 20px;
				text-decoration: none;
				position: relative;
			}
			#dialog-link span.ui-icon {
				margin: 0 5px 0 0;
				position: absolute;
				left: .2em;
				top: 50%;
				margin-top: -8px;
			}
			.fakewindowcontain .ui-widget-overlay {
				position: absolute;
			}
		</style>

	</head>
	<body>
		<h1>Система учёта проектов ИРЦМ</h1>
		<div id="tabs">
			<ul>
				<li><a href="#tabs-1" id="t1">Просмотр</a></li>
				<li><a href="#tabs-2" id="t2">Добавление</a></li>
			</ul>
			
			<div id="tabs-1">
				<form name="form_journal" id="form_journal" method="post">
					
					<div id="set">
						<input type="submit" value="Удалить"  name="btn" onclick="return validate_form()">
						<input type="button" value="Изменить" id="show-dialog">
						<input type="submit" value="Все проекты" name="btn">
						<input type="submit" value="Выход" name="btn">
					</div>
					
					<div id="tablewrapper">
						<div id="tableheader">
        					<div class="search">
        						<input type="text" id="query" onkeyup="sorter.search('query')" placeholder = "Поиск..."/>
                				<select id="columns" onchange="sorter.search('query')"></select>      
        					</div>
        	
            				<span class="details">
								<div>Записи <span id="startrecord"></span>-<span id="endrecord"></span> из <span id="totalrecords"></span></div>
        						<div><a href="javascript:sorter.reset()">сброс</a></div>
        					</span>
        				</div>
        				<table cellpadding="0" cellspacing="0" border="0" id="table" class="tinytable">
            				<thead>
                				<tr>
                 					<th class="nosort"></th>
                    				<th><h3>№ п/п<h3></th>
                    				<th><h3>Название проекта</h3></th>
                    				<th><h3>Краткое описание</h3></th>
                    				<th><h3>Среда разработки</h3></th>
                    				<th><h3>Расположение(SVN)</h3></th>
                    				<th><h3>Автор</h3></th>
                    				<th><h3>Текущий разработчик</h3></th>
                    				<th><h3>Замещающие разработчики</h3></th>
                    				<th><h3>Где используется</h3></th>
                    				<th><h3>Сервер</h3></th>
									<th><h3>Технолог</h3></th>
                    				<th><h3>Статус проекта</h3></th>
                				</tr>
            				</thead>
       						<tbody>
            					<%   
									ResultSet rs = null;
									int i = 1;	
            						rs = (ResultSet)session.getAttribute("rs");
               						while (rs.next()) {	
             					%>
           						<tr>
                					<td><input type="radio" name="sel" value="<%=rs.getString(1) %>"  id = "row<%=i %>" ></td>
                					<td width="25"><%=i %></td>
                					<td width="250"><%=rs.getString(2) %></td>
                					<td width="350"><%=rs.getString(3) %></td>
                					<td><%=rs.getString(4) %></td>
                					<td><%=rs.getString(5) %></td>
                					<td><%=rs.getString(6) %></td>
                					<td><%=rs.getString(7) %></td>
                					<td><%=rs.getString(12) %></td>
                					<td><%=rs.getString(8) %></td>
                					<td><%=rs.getString(9) %></td>
                					<td><%=rs.getString(11) %></td>
                					<td><%=rs.getString(10) %></td>
             					</tr>    
             					<% 
              							i++;
                					} 
             					%>
        					</tbody>
        				</table>
        				<div id="tablefooter">
          					<div id="tablenav">
            					<div>
                    				<img src="css/images/first.gif" width="16" height="16" alt="First Page" onclick="sorter.move(-1,true)" />
                    				<img src="css/images/previous.gif" width="16" height="16" alt="First Page" onclick="sorter.move(-1)" />
                    				<img src="css/images/next.gif" width="16" height="16" alt="First Page" onclick="sorter.move(1)" />
                    				<img src="css/images/last.gif" width="16" height="16" alt="Last Page" onclick="sorter.move(1,true)" />
                				</div>
                				<div>
                					<select id="pagedropdown"></select>
								</div>
                				<div>
                					<a href="javascript:sorter.showall()">Показать всё</a>
                				</div>
            				</div>
							<div id="tablelocation">
            					<div>
                    				<select onchange="sorter.size(this.value)">
                    					<option value="5">5</option>
                        				<option value="10" selected="selected">10</option>
                        				<option value="20">20</option>
                        				<option value="50">50</option>
                        				<option value="100">100</option>
                    				</select>
                    				<span>Записей на страницу</span>
                				</div>
                				<div class="page">Страница <span id="currentpage"></span> из <span id="totalpages"></span></div>
            				</div>
        				</div>
    				</div>
      			</form>
			</div>
			
			<div id="tabs-2">
	  			<form action="index" method="POST">
		 			<table width="100%">
		 				<tr>
		 					<td><label for = "name">Название программы</label></td>
            				<td><input type = "text" id = "name" name = "name" /><br><br></td>
						</tr>
						<tr>
		 					<td><label for = "desc">Краткое описание</label></td>
            				<td><textarea id = "desc" name = "desc"></textarea><br><br></td>
						</tr>
						<tr>
		 					<td><label for = "env">Среда разработки</label></td>
            				<td><input type = "text" id = "env" name = "env" /><br><br></td>
						</tr>
						<tr>
		 					<td><label for = "path">Расположение</label></td>
            				<td><input type = "text" id = "path" name = "path"/><br><br></td>
						</tr>
						<tr>
		 					<td><label for = "aut">Автор</label></td>
            				<td><input type = "text" id = "aut" name = "aut"/><br><br></td>
						</tr>
						<tr>
		 					<td><label for = "dev">Текущий разработчик</label></td>
            				<td><input type = "text" id = "dev" name = "dev" /><br><br></td>
						</tr>
						<tr>
		 					<td><label for = "sub">Замещающие разработчики</label></td>
            				<td><input type = "text" id = "sub" name = "sub" /><br><br></td>
						</tr>
						<tr>
		 					<td><label for = "used">Где используется</label></td>
            				<td><input type = "text" id = "used" name = "used" /><br><br></td>
						</tr>
						<tr>
		 					<td><label for = "serv">Сервер</label></td>
            				<td><input type = "text" id = "serv" name = "serv" /><br><br></td>
						</tr>
						<tr>
		 					<td><label for = "tech">Технолог</label></td>
            				<td><input type = "text" id = "tech" name = "tech" /><br><br></td>
						</tr>
						<tr>
		 					<td><label for = "status">Статус</label></td>
            				<td>
              					<select id = "selectmenu" name = "status"> 
									<option selected="selected">В разработке</option> 
									<option>На отладке</option> 
									<option>На производстве</option>
									<option>Снят с сопровождения</option>  
								</select><br><br>
		    				</td>
						</tr>
					</table>     
        			<input type = "submit" value = "Добавить" name="btn"><br>
				</form>
			</div>
		</div>
		
		<div id="dialog" title="Редактирование">	
			<form action="index" method="post">
		   
            	<label for = "nameD">Название программы</label>
            	<input type = "text" id = "nameD" name = "nameD"  /><br><br>

            	<label for = "descD">Краткое описание</label>
            	<div><textarea id = "descD" name = "descD"></textarea></div><br>
            
            	<label for = "envD">Среда разработки</label>
            	<input type = "text" id = "envD" name = "envD" /><br><br>
           
            	<label for = "pathD">Расположение</label>
            	<input type = "text" id = "pathD" name = "pathD" /><br><br>
            
            	<label for = "autD">Автор</label>
            	<input type = "text" id = "autD" name = "autD" /><br><br>
            
            	<label for = "devD">Текущий разработчик</label>
            	<input type = "text" id = "devD" name = "devD" /><br><br>
   
            	<label for = "subD">Замещающие разработчики</label>
            	<input type = "text" id = "subD" name = "subD" /><br><br>

            	<label for = "usedD">Где используется</label>
            	<input type = "text" id = "usedD" name = "usedD" /><br><br>

            	<label for = "servD">Сервер</label>
            	<input type = "text" id = "servD" name = "servD" /><br><br>
            
            	<label for = "techD">Технолог</label>
            	<input type = "text" id = "techD" name = "techD" /><br><br>

            	<label for = "statusD">Статус</label>
          
            	<select id = "statusD" name = "statusD"> 
					<option selected="selected">В разработке</option> 
					<option>На отладке</option> 
					<option>На производстве</option> 
				</select><br>
            
        		<input type = "hidden" id="rowId" name = "rowId">
        
            	<input type="submit" value="Сохранить" name="btn">
       		</form>
		</div>

		<script type="text/javascript" src="js/table.js"></script>
		<script type="text/javascript">
			var sorter = new TINY.table.sorter('sorter','table',{
				headclass:'head',
				ascclass:'asc',
				descclass:'desc',
				evenclass:'evenrow',
				oddclass:'oddrow',
				evenselclass:'evenselected',
				oddselclass:'oddselected',
				paginate:true,
				size:10,
				colddid:'columns',
				currentid:'currentpage',
				totalid:'totalpages',
				startingrecid:'startrecord',
				endingrecid:'endrecord',
				totalrecid:'totalrecords',
				hoverid:'selectedrow',
				pageddid:'pagedropdown',
				navid:'tablenav',
				sortcolumn:1,
				sortdir:1,
				init:true
			});
  		</script>
  		
	</body>
</html>