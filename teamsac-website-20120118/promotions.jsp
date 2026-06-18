<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" errorPage="/500.html"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.teamsacramento.web.HibernateFilter"%>
<%@page import="org.teamsacramento.domain.persistence.MemberDAO"%>
<%@page import="java.util.Date"%>
<%@page import="com.tauasa.commons.util.DateUtils"%>
<%@page import="java.util.List"%>
<%@page import="org.teamsacramento.domain.util.RecentPromotionsPage"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.teamsacramento.domain.Rank"%>
<%@page import="org.teamsacramento.domain.BeltColor"%>
<html>
<head>
    <title>Team Sacramento Judo - Recent Belt Promotions</title>
    <meta name="description" content="Team Sacramento Judo" />
    <meta name="keywords" content="Judo, Team Sacramento, Sacramento, Roseville, Folsom, Lincoln, Rocklin, California, ippon, randori, shiai, judo blog, judo merchandise" />
    <meta name="robots" content="index, follow" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache" />

	<link rel="alternate" href="http://teamsacramentojudo.blogspot.com/feeds/posts/default?alt=rss" type="application/rss+xml" title="Team Sacramento Judo News"/>
    <link REL="SHORTCUT ICON" HREF="http://www.teamsacramento.org/img/favicon.ico">
    <link rel="stylesheet" rev="stylesheet" href="inc/new.css" type="text/css"/>
    <style type="text/css">
    div.content p{
        width: 600px;
    }
    </style>

    <script src="inc/jquery-1.2.6.pack.js"></script>
    <script type="text/javascript" src="inc/thickbox-compressed.js"></script>
    <link rel="stylesheet" href="inc/thickbox.css" type="text/css" media="screen" />
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-28250945-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>
</head>


<body>

    <div class="page">

        <div class="header">
            <span class="logo"><a href="index.html"><img src="img/logo.jpg" width="220" height="67" alt="Team Sacramento Judo"/></a></span>
            <span style="background:#FFFFFF; text-align: right; vertical-align:middle; float:right; width:270px; height:74px; padding-right: 10px; padding-top: 10px;">
            <br/>
            <a href="http://teamsacramentojudo.blogspot.com/" target="_blank" title="Visit our Blog"><img src="img/blogger.png" width="32" height="32" border="0"/></a>
            <a href="http://www.facebook.com/pages/Team-Sacramento-Judo/146123512078243?v=app_2309869772" target="_blank" title="Visit us on Facebook"><img src="img/facebook.png" width="32" height="32" border="0"/></a>
            <a href="http://twitter.com/teamsacjudo" target="_blank" title="Follow us on Twitter"><img src="img/twitter.png" width="32" height="32" border="0"/></a>
            <a href="http://vimeo.com/judo" target="_blank" title="Team Sacramento Vimeo Channel"><img src="img/vimeo.png" width="32" height="32" border="0"/></a>
            </span>
        </div>

        <div class="nav">
            <ul>
                <li><a href="home.html">Home</a></li>
                <li><a href="schedule.html">Schedule</a></li>
                <li><a href="contact.html">Contact</a></li>
                <li class="nav_selected"><a href="news.html">News</a></li>
                <li><a href="video.html">Gallery</a></li>
                <li><a href="join.html">How Do I Join?</a></li>
                <li><a href="sponsors.html">Sponsors</a></li>
                <li><a href="store.html">Store</a></li>
            </ul>
        </div>

        <div class="subnav">
            <ul>
                <li><a href="news.html">Announcements</a></li>
                <li><a href="tournaments.jsp">Tournament Results</a></li>
                <li><a href="promotions.jsp">Recent Belt Promotions</a></li>
            </ul>
        </div>

<%
int _months = 12;
if(request.getParameter("months")!=null){
	try{
		_months = Integer.parseInt(request.getParameter("months"));
	}catch(Exception e){
	}
}
Session hibSession = (Session)request.getAttribute(HibernateFilter.SESSION);
MemberDAO dao = new MemberDAO(hibSession);
Date endDate = new Date();
Date startDate = DateUtils.adjustMonth(endDate, -1 * _months);
List list = dao.getPromotions(startDate, endDate);
RecentPromotionsPage promoPage = new RecentPromotionsPage(list);
%>

        <div class="content">

            <h2>Recent Belt Promotions</h2>
            
            <%if(promoPage.size()==0){%>
            <p>No recent promotions</p>
            <%}else{%>
            
            	<%
            	Iterator months = promoPage.getMonths().iterator();
            	while(months.hasNext()){
            		Date month = (Date)months.next();
            	%>
            	<h3><%=DateUtils.formatDate(month, "MMMM yyyy")%></h3>
            	<p>
            	<%
            		List items = promoPage.getPromotionsForMonth(month);
            		for(int i=0;i<items.size();i++){
            			Rank r = (Rank)items.get(i);
            			String belt = "<img src=\"img/belt/"+r.getBeltColor().name().toLowerCase()+".gif\" border=\"0\"/>";
            			if(r.getBeltColor()==BeltColor.Black || 
           					r.getBeltColor()==BeltColor.Brown || 
           					r.getBeltColor()==BeltColor.Purple){
            				belt += " ("+r.getType().name()+")";
            			}
            	%>
            	<%=DateUtils.toMMDDYYYY(r.getDate())%> - <%=r.getMember().getPerson().getFirstName()%> <%=r.getMember().getPerson().getLastName()%> <%=belt%><br/>
            	<%
            		}
            	%>
            	</p>
            	<%
            	}
            	%>
            
            <%}%>

            <p/><br/>

        </div>
        
<br/>        
<div align="center">
<script type="text/javascript"><!--
google_ad_client = "ca-pub-0448145393837475";
/* TSJ - text/image 728x90 */
google_ad_slot = "7901523503";
google_ad_width = 728;
google_ad_height = 90;
//-->
</script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
</div>
<br/>

        <div class="footer">
            &copy;2004-2012 Team Sacramento Judo. All rights reserved.<br/>
            Last Update: 01/18/2012 3:10AM
        </div>


    </div>

</body>



</html>
