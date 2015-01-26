import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.sql.*;
import java.io.*;
import javax.naming.*;

public class Pool extends HttpServlet
{
	private DataSource fuenteDatos = null;
	String errorInicial = null;

	public void init()
		throws ServletException 
	{
		try {
			// recuperamos el contexto inicial y la referencia a la fuente de datos
            Context ctx = new InitialContext();
            fuenteDatos = (DataSource) ctx.lookup("java:comp/env/jdbc/pde");
        } catch (Exception e) {
            throw new ServletException("Imposible recuperar java:comp/env/jdbc/pde", e);
        }
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
        Connection con = null;
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		out.println("<html><head><title>Ejemplo de acceso a datos</title></head><body>");

		try
		{
			con = fuenteDatos.getConnection();
			out.println("<h1>Empresas</h1><br/>");
			try
			{
				if(con == null)
				{
					out.println("</br>Error al recuperar la conexion, es nula");
					throw new ServletException("---Problemas con la conexion");
				}
				PreparedStatement prepStat = con.prepareStatement("SELECT * FROM Empresas");
				ResultSet resCons = prepStat.executeQuery();
				out.println("<table border=1><td>Empresa</td><td>Direccion</td><td>Creacion</td>");
				while (resCons.next())
				{
					String cam1 = resCons.getString("Empresa");
					String cam2 = resCons.getString("Direccion");
					String cam3 = resCons.getString("AnioCreacion");
					out.println("<tr><td>"+cam1+"</td><td>"+cam2+"</td><td>"+cam3+"</td></tr>");
				}
				out.println("</table>");
			} catch (Exception e) {
				out.println("</br>Error al procesar consulta " + e.getMessage());
			}
		} catch (Exception e) {
			out.println("<h3>Error al procesar la conexion "+e.getMessage()+"</h3>");
		} finally { // pase lo que pase retornamos la conexion
			try
			{
				con.close();
			} catch (Exception e) {
				out.println("</br>Error en proceso " + e.getMessage());
			}
		}
		out.println("</body></html>");
		out.close(); // Cerramos buffer
    }

	public void destroy()
	{
	}
}
