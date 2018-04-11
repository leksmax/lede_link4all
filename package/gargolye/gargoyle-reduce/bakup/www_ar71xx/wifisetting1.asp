<%
eval $( gargoyle_session_validator -c "$COOKIE_hash" -e "$COOKIE_exp" -a "$HTTP_USER_AGENT" -i "$REMOTE_ADDR" -r "login1.asp" -t $(uci get gargoyle.global.session_timeout) -b "$COOKIE_browser_time"  )
echo ""
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>AP client</title>
    <link rel="stylesheet" type="text/css" href="css/layout.css" />
    <link rel="stylesheet" type="text/css" href="css/table.css" />
    <link rel="stylesheet" type="text/css" href="css/main.css" />
    <script type="text/javascript" src="jjs/jquery.js"></script>
<link rel="stylesheet" type="text/css" href="css/form.css" />
  <script type="text/javascript">
        function setwifi(){
         // document.getElementById("form0").submit();
          $("#status").html("正在设置....请等待网络重启！");
         var form = new FormData(document.getElementById("form0"));
           $.ajax({
          url: "/cgi-bin/setathwifi.sh",
          type: "post",
          data:form, 
          processData:false,
          contentType:false,
         // contentType: "application/json; charset=utf-8",
          success: function(data) {
               //alert("设置结果:"+data["success"])
             $("#status").html("设置已完成");
          },
          error: function(error) {
            //alert("调用出错" + error.responseText);
          }
        });
   }
	  $(window).on('load', function () {

      });
      function showpasswd(){
      var pass=document.getElementById("pass")
      if (pass.type=="password"){
         pass.type="text"
         document.getElementById("dispass").value="隐藏密码"
         }
        else{
         pass.type="password"
        document.getElementById("dispass").value="显示密码"
        }
     }
    </script>
</head>
<body>
    <div class="current">当前位置：无线设置 > 2.4G基本设置</div>
     <div class="wrap-main" style="position: relative;min-height: 100%;">
        <div class="wrap">
            <div class="title">2.4G基本设置 <p style="display:inline;color:#e81717;font-size:x-large;margin-left: 100px;" id="status"></p></div>
            <div class="wrap-form">
                <form class="form-info" id="form0" >
                    <label>
                        <div class="name"></div>
                        <div>
                            <input type="checkbox" value="1" name="enable" <%= `uci get wireless.radio0.disable >/dev/null 2>&1  || echo checked` %>/>开启无线
                        </div>
                    </label>
                      <label>
                                <div class="name">SSID 名称：</div>
                                <div>
                                    <input name="ssid" type="text" value="<%= `uci get wireless.@wifi-iface[0].ssid` %>"  />
                                    <input type="checkbox" value="1" name="hidssid" <%= `uci get wireless.@wifi-iface[0].hidden >/dev/null 2>&1  && echo checked` %>/>隐藏SSID
                                </div>
                            </label>
                            <label>
                                <div class="name">加密方式：</div>
                                <div>
                                    <select name="etype"  >
                                        <option value="none" <% [ `uci get wireless.@wifi-iface[0].encryption |grep none` ] && echo 'selected="true"' %> >不加密</option>
                                        <option value="psk2" <% [ `uci get wireless.@wifi-iface[0].encryption |grep psk` ] && echo 'selected="true"' %> >加密</option>
                                    </select>
                                </div>
                            </label>
                            <label>
                                <div class="name">密码：</div>
                                <div>
                                    <input id="pass" name="epwd" type="password"  value="<%= `uci get wireless.@wifi-iface[0].key` %>" />
                                    <input id="dispass" class="green-btn" type="button" value="显示密码" onclick="showpasswd()"/>
                                </div>
                            </label>
                     <label>
                        <div class="name">信道</div>
                        <div>
                            <select name="channel" id="channel">
                                <option value="0" <% [ `uci get wireless.radio0.channel` -eq 0 ] && echo 'selected="true"' %>>Auto</option>
                                <option value="1" <% [ `uci get wireless.radio0.channel` -eq 1 ] && echo 'selected="true"' %>>1</option>
                                <option value="2" <% [ `uci get wireless.radio0.channel` -eq 2 ] && echo 'selected="true"' %>>2</option>
                                <option value="3" <% [ `uci get wireless.radio0.channel` -eq 3 ] && echo 'selected="true"' %>>3</option>
                                <option value="4" <% [ `uci get wireless.radio0.channel` -eq 4 ] && echo 'selected="true"' %>>4</option>
                                <option value="5" <% [ `uci get wireless.radio0.channel` -eq 5 ] && echo 'selected="true"' %>>5</option>
                                <option value="6" <% [ `uci get wireless.radio0.channel` -eq 6 ] && echo 'selected="true"' %>>6</option>
                                <option value="7" <% [ `uci get wireless.radio0.channel` -eq 7 ] && echo 'selected="true"' %>>7</option>
                                <option value="8" <% [ `uci get wireless.radio0.channel` -eq 8 ] && echo 'selected="true"' %> >8</option>
                                <option value="9" <% [ `uci get wireless.radio0.channel` -eq 9 ] && echo 'selected="true"' %> >9</option>
                                <option value="10" <% [ `uci get wireless.radio0.channel` -eq 10 ] && echo 'selected="true"' %> >10</option>
                                <option value="11" <% [ `uci get wireless.radio0.channel` -eq 11 ] && echo 'selected="true"' %> >11</option>
                                <option value="12" <% [ `uci get wireless.radio0.channel` -eq 12 ] && echo 'selected="true"' %> >12</option>
                                <option value="13" <% [ `uci get wireless.radio0.channel` -eq 13 ] && echo 'selected="true"' %> >13</option>
                            </select>
                        </div>
                    </label>
                    <label>
                        <div class="name">频宽</div>
                        <div>
                            <select name="bw" id="bw">
                                <option value="HT20" <% [ `uci get wireless.radio0.htmode |grep 20` ] && echo 'selected="true"' %> >20MHz</option>
                                <option value="HT40" <% [ `uci get wireless.radio0.htmode |grep 40` ] && echo 'selected="true"' %> >40MHz</option>
                            </select>
                        </div>
                    </label>
                    <label>
                        <div class="name">发射功率</div>
                        <div>
                            <select name="txpower" id="stong">
                                <option value="23" <% [ `uci get wireless.radio0.txpower |grep 23` ] && echo 'selected="true"' %> >高</option>
                                <option value="19" <% [ `uci get wireless.radio0.txpower |grep 19` ] && echo 'selected="true"' %> >中</option>
                                <option value="15" <% [ `uci get wireless.radio0.txpower |grep 15` ] && echo 'selected="true"' %> >低</option>
                            </select>
                        </div>
                    </label>
                </form>
				  <div class="btn-wrap">
					<div class="save-btn fr"><a href="javascript:setwifi()">保存</a></div>
					</div>
            </div>
        </div>
    </div>
</body>
</html>
