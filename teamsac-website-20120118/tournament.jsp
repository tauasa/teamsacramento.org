<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" errorPage="/500.html"%>

<%@page import="org.hibernate.Session"%>
<%@page import="org.teamsacramento.web.HibernateFilter"%>
<%@page import="org.teamsacramento.domain.persistence.TournamentDAO"%>
<%@page import="org.teamsacramento.domain.Tournament"%>
<%@page import="org.teamsacramento.domain.TournamentVenue"%>
<%@page import="com.tauasa.commons.util.DateUtils"%>
<%@page import="java.util.List"%>
<%@page import="org.teamsacramento.domain.TournamentEntry"%>
<style type="text/css">
td {
    font-family: verdana,sans-serif;
    font-size:11px;
    font-weight:normal;
    color:#000;
}
th{
    font-family: verdana,sans-serif;
    font-size:11px;
    font-weight:bold;
    color:#fff;
    background-color:#EC222A;
}
th.topSpan{
    font-family: verdana,sans-serif;
    font-size:11px;
    font-weight:bold;
    color:#fff;
    background-color:#005CAD;
}
</style>

<%
Session hibSession = (Session)request.getAttribute(HibernateFilter.SESSION);
TournamentDAO dao = new TournamentDAO(hibSession);
Tournament t = dao.getTournament(new Long(request.getParameter("id")));
TournamentVenue venue = t.getVenue();
List entries = t.getSortedEntries();
%>

<div style="text-align: justify; font-family:verdana,sans-serif; font-size:11px;">

    <STRONG>Venue:</STRONG> <%=venue.getName()%><BR/>
    <STRONG>City:</STRONG> <%=venue.getAddress().getCity()%><BR/>
    <STRONG>Date:</STRONG> <%=DateUtils.toMMDDYYYY(t.getStartDate())%><BR/>
    <STRONG>Type:</STRONG> <%=t.getType().name()%><BR/><BR/>

    <p>
    <table border="1" cellpadding="2" cellspacing="0" width="100%">
        <tr>
            <th class="topSpan" colspan="3"><%=entries.size()%> Team Sacramento Competitors</th>
        </tr>    
        <tr>
            <th>Name</th>
            <th>Division</th>
            <th>Result</th>
        </tr>
        <%
        for(int i=0;i<entries.size();i++){
        	TournamentEntry e = (TournamentEntry)entries.get(i);
        %>
        <tr>
            <td><%=e.getMember().getPerson().getFirstName()%> <%=e.getMember().getPerson().getLastName()%></td>
            <td><%=e.getAgeDivision().description()%></td>
            <td><%=e.getResult().name()%></td>
        </tr>        
        <%
        }
        %>

    </table>

    </p>

</div>
