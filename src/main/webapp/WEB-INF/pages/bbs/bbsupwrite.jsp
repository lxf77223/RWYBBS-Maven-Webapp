<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'bbswrite.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="${basePath}/css/semantic.css"/>
	<link rel="stylesheet" type="text/css" href="${basePath}/css/bbs/bbswrite.css" />
	<link rel="stylesheet" type="text/css" href="${basePath}/simditor/simditor.css" />
	<script src="${basePath}/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="${basePath}/simditor/module.js"></script>
	<script type="text/javascript" src="${basePath}/simditor/hotkeys.js"></script>
	<script type="text/javascript" src="${basePath}/simditor/uploader.js"></script>
	<script type="text/javascript" src="${basePath}/simditor/simditor.js"></script>
	<script src="${basePath}/js/semantic.js" type="text/javascript" charset="utf-8"></script>
	<script src="${basePath}/js/vue1.js" type="text/javascript" charset="utf-8"></script>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
	<body id="box">
		<!--  ==========  -->
		<!--  =   标题      =  -->
		<!--  ==========  -->
		<div class="ui segment fixed basic menu">
			<div class="title-main">
				<div class="ui image title-main-left">
					<a href="http://47.95.220.233/RWY/index.jsp">
						<img src="${basePath}/img/logo.png"/>
					</a>
				</div>
				<div class="title-main-in">
					<strong>创作中心</strong>
				</div>
				<div class="ui text menu title-main-right">
					<div class="right item">
						<a href="#">
							<div class="but">
								${username}
							</div>
						</a>
					</div>
					<div class="right item but">
						<a href="${basePath}/bbs/index">
							<div class="but">
								首页
							</div>
						</a>
					</div>
				</div>
			</div>
		</div>
		<!--  ==========  -->
		<!--  =   主体      =  -->
		<!--  ==========  -->
		<div class="ui segment basic vertical main">
			<div class="ui grid container">
				<div class="sixteen wide column">
					<div class="ui raised segment very padded">
						<div class="ui form">
							<div class="two fields">
								<div class="field">
									<label>标题</label>
									<input type="text" id="title"  value="${note.getTtopic()}">
								</div>
								<div class="field">
									<div class="two fields">
										<div class="field">
											<label>心情</label>
											<input type="text" readonly="readonly" id="title"  value="${note.getTemotion()}">
										</div>
										<div class="field">
											<label>板块</label>
											<input type="text" readonly="readonly" id="title"  value="${note.getSname()}">
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--编辑器-->
					<div class="ui segment very padded raised">
						<label><strong>内容</strong></label>
						<textarea id="editor" placeholder="此处开始书写" autofocus></textarea>
						<input class="ui teal button" type="button" onclick="wr()" id="button" value="提交" />
						<br /><br /><br />
					</div>
				</div>
			</div>
		</div>
		
		
		
		<!--  ==========  -->
		<!--  =   底部      =  -->
		<!--  ==========  -->
		<div class="ui segment basic vertical">
			<div class="ui divider"></div>
			<div class="foot menu">
				<div class="ui text left menu">
					<a class="item" href="">相关连接</a>
					<a class="item" href="http://47.95.220.233/upload/Pano2VR.zip">
						软件下载
					</a>
					<a class="item" href="http://47.95.220.233/RWY/Pano2Vr.htm">
						|使用手册|
					</a>
					
				</div>
				<div class="ui image foots">
					<img src="${basePath}/img/logofooter2.png"/>
				</div>
				<div class="rights">
					© Copyright 2018 rwy.com 湖南农业大学“任我遨游”团队制作<br />
				</div>
			</div>
		</div>
		
		<script type="text/javascript">
			/*文本编辑器*/
			var editor = new Simditor({
			textarea: $('#editor'),
			//optional options
			placeholder: '',
			defaultImage: '${basePath}/simditor/images/image.png',
			params: {},
			upload : {
				//文件上传的接口地址
                url : '${basePath}/bbs/write/upimg', 
                //键值对,指定文件上传接口的额外参数,上传的时候随文件一起提交
                params: null, 
                //服务器端获取文件数据的参数名
                fileKey: 'photo', 
                connectionCount: 3,
                leaveConfirm: '正在上传文件'
            },
			tabIndent: true,
			toolbar : [
				  'title','|',
				  'bold',
				  'italic',
				  'underline',
				  'strikethrough','|',
				  'fontScale',
				  'color','|',
				  'ol',      
				  'ul', '|',   
				  'blockquote',
				  'code',    
				  'table',
				  'link',
				  'image','|',
				  'hr',   
				  'indent',
				  'outdent',
				  'alignment',
				],
			toolbarFloat: true,
			toolbarFloatOffset: 0,
			toolbarHidden: false,
			pasteImage: true,
			cleanPaste: false
		});
		
		/* 数据回填 */
		editor.setValue('${note.getTcontents()}');
		
		
		/* 写论坛 */
		function wr(){
			var title = $("#title").val();
			var text = editor.getValue();
			var tid = ${note.getTid()};
			$.ajax({
				type:"post",
				url:"${basePath}/bbs/upwrite/do",
				data:{
					"title":title,
					"text":text,
					"tid":tid
				},
				success:function(data){
					if(data=="success"){
						alert("提交成功！");
						window.location.href = "${basePath}/bbs/index";
					}else if(data=="error"){
						alert("出错! 请重试！");
					}
				}
			});
		};
		
		</script>
	</body>
</html>