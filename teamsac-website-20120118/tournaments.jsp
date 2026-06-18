<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" errorPage="/500.html"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.teamsacramento.web.HibernateFilter"%>
<%@page import="org.teamsacramento.domain.persistence.TournamentDAO"%>
<%@page import="java.util.Date"%>
<%@page import="com.tauasa.commons.util.DateUtils"%>
<%@page import="java.util.List"%>
<%@page import="org.teamsacramento.domain.util.TournamentResultsPage"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.teamsacramento.domain.Tournament"%>
<%@page import="com.tauasa.commons.util.Utils"%>
<html>
<head>
    <title>Team Sacramento Judo - Tournament Results</title>
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
        width: 400px;
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
TournamentDAO dao = new TournamentDAO(hibSession);
Date endDate = new Date();
Date startDate = DateUtils.adjustMonth(endDate, -1 * _months);
List list = dao.getTournaments(null, startDate, endDate, null, null);
TournamentResultsPage tPage = new TournamentResultsPage(list);
%>

        <div class="content">

            <h2>Tournament Results</h2>
            
            <%if(tPage.size()==0){%>
            <p>No results available</p>
            <%}else{%>
            
            	<%
            	Iterator months = tPage.getMonths().iterator();
            	while(months.hasNext()){
            		Date month = (Date)months.next();
            	%>
            	<h3><%=DateUtils.formatDate(month, "MMMM yyyy")%></h3>
            	<p>
            	<%
            		List items = tPage.getTournamentsForMonth(month);
            		for(int i=0;i<items.size();i++){
            			Tournament t = (Tournament)items.get(i);
            	%>
            	<%=DateUtils.toMMDDYYYY(t.getStartDate())%> - 
	            	<%if(Utils.isEmpty(t.getEntries())){%>
	            	<a href="javascript:alert('Data has not been entered for this tournament');" title="<%=t.getName()%>"><%=t.getName()%></a> (<%=t.getVenue().getAddress().getCity()%>)<br/>
	            	<%}else{%>
	            	<a href="tournament.jsp?id=<%=t.getId()%>&KeepThis=true&TB_iframe=true&height=300&width=450" class="thickbox" title="<%=t.getName()%>"><%=t.getName()%></a> (<%=t.getVenue().getAddress().getCity()%>)<br/>
	            	<%}%>
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
