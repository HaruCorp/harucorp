import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.net.*;
import java.util.*;

public class CerrarSession extends HttpServlet
{
	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		HttpSession session=request.getSession(true);
		session.invalidate();
		response.sendRedirect("gestion2/login.html");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		// Llamar a doGet() para hacerlo independiente del tipo de llamado
		doGet(request, response);
	}
}