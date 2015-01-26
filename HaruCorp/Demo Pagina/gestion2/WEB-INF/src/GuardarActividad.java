import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class GuardarActividad implements Filter
{
	private DataSource fuenteDatos= null;
	String errorInicial = null;
	public void init(FilterConfig config) 
		throws ServletException
	{
		
		try {
			// recuperamos el contexto inicial y la referencia a la fuente de datos
			Context ctx = new InitialContext();
            fuenteDatos = (DataSource) ctx.lookup("java:comp/env/jdbc/bd_gestion_talleres");
        } catch (Exception e) {
            throw new ServletException("Imposible recuperar java:comp/env/jdbc/bd_gestion_talleres", e);
        }
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
		throws java.io.IOException, ServletException
	{
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session=req.getSession(true);
		Connection con = null;
		
		
		try
		{
			con = fuenteDatos.getConnection();
			try
			{
				if(con == null)
				{
					throw new ServletException("---Problemas con la conexion");
				}
				String nombreCoordinador = req.getParameter("nombreCoordinador");
				String usuario = req.getParameter("usuario");
				String password = req.getParameter("password");

				String nombreActividad = req.getParameter("nombreActividad");
				String tipo = req.getParameter("tipo");
				String inicio = req.getParameter("inicio");
				String duracion = req.getParameter("duracion");

				if(nombreActividad==null){
					chain.doFilter(request, response);
				}else{
					System.out.println("Preparando consulta 1");
					PreparedStatement prepStat = con.prepareStatement("INSERT INTO coordinadores (nombre, usuario, contrasena) VALUES(?,?,AES_ENCRYPT(?,'upiiz'))");
					prepStat.setString(1,nombreCoordinador);
					prepStat.setString(2,usuario);
					prepStat.setString(3,password);
					prepStat.execute();
					System.out.println("Ejecutando consulta 1");
					System.out.println("Preparando consulta 2");
					PreparedStatement prepStat1 = con.prepareStatement("INSERT INTO actividades (nombre_actividad, tipo, inicio, duracion, id_coordinador) VALUES(?,?,?,?,'SELECT id_coordinador FROM coordinadores WHERE usuario=?'");
					prepStat1.setString(1,nombreActividad);
					prepStat1.setString(2,tipo);
					prepStat1.setString(3,inicio);
					prepStat1.setString(4,duracion);
					prepStat1.setString(5,usuario);
					System.out.println("Ejecutando consulta 2.1");
					prepStat1.execute();

					System.out.println("Ejecutando consulta 2");
					String requestURI = req.getRequestURI();
					String toReplace = requestURI.substring(requestURI.indexOf("/") + 1, requestURI.length());
					String newURI = requestURI.replace(toReplace, "form_actividad.html");
					request.getRequestDispatcher(newURI).forward(request, response);
				}
				
				
			} catch (Exception e) {
				System.out.println("Error al procesar consulta " + e.getMessage());
			}
		} catch (Exception e) {
			System.out.println("Error al procesar la conexion "+e.getMessage());
		} finally { // pase lo que pase retornamos la conexion
			try
			{
				con.close();
			} catch (Exception e) {
				System.out.println("Error en proceso " + e.getMessage());
			}
		}
	}

	public void destroy()
	{}
}
