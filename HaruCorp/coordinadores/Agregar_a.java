import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class AgregarAlumno extends HttpServlet
{
	private DataSource fuenteDatos= null;
	String errorInicial = null;
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException
	{
		Connection con = null;
		HttpSession session=request.getSession(true);
		PrintWriter out = response.getWriter();
		String boleta=request.getParameter("boleta");
		String id_actividad=(String)session.getAttribute("id_actividad");
		String id_coordinador=(String)session.getAttribute("id_coordinador");
		String modalidad=(String)session.getAttribute("modalidad");
		out.println("<html><head></head><body>");
		try {
					// recuperamos el contexto inicial y la referencia a la fuente de datos
		            Context ctx = new InitialContext();
		            fuenteDatos = (DataSource) ctx.lookup("java:comp/env/jdbc/pde");
		        } catch (Exception e) {
		            throw new ServletException("Imposible recuperar java:comp/env/jdbc/pde", e);
		        }
		try
		{
			con = fuenteDatos.getConnection();
			try
			{
				if(con == null)
				{
					out.println("</br>Error al recuperar la conexion, es nula");
					throw new ServletException("---Problemas con la conexion");
				}
				PreparedStatement prepStat = con.prepareStatement("SELECT num_boleta FROM alumnos where num_boleta=?");

				int idaux=Integer.parseInt(boleta);
				//int actividad=Integer.parseInt(id_actividad);
                prepStat.setInt(1,idaux);

				ResultSet resCons = prepStat.executeQuery();
				if (resCons.next())
				{
					String cam1 = resCons.getString("num_boleta");
					PreparedStatement prepStat1 = con.prepareStatement("INSERT INTO lista (id_actividad,num_boleta) VALUES(?,?)");
					prepStat1.setString(1,id_actividad);
					prepStat1.setString(2,cam1);
					prepStat1.execute();
				}else{

				}

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
		response.sendRedirect("http://localhost:8080/gestion2/coordinadores/agregar_alumno.jsp?id_coordinador='"+id_coordinador+"'&id='"+id_actividad+"'&modalidad='"+modalidad+"'");
	}

	public void destroy()
	{}
}
