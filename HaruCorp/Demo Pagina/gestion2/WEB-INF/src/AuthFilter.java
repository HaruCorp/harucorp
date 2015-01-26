import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class AuthFilter implements Filter
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
		String usuario1= (String) session.getAttribute("usuario1");
		Connection con = null;
		
		if(usuario1==null){
			try
			{
				con = fuenteDatos.getConnection();
				try
				{
					if(con == null)
					{
						throw new ServletException("---Problemas con la conexion");
					}
					String usuarioEnviado = req.getParameter("usuario");
					String password = req.getParameter("password");
					PreparedStatement prepStat = con.prepareStatement("SELECT * FROM coordinadores WHERE usuario= ? AND contrasena= AES_ENCRYPT(?,'upiiz')");
					prepStat.setString(1,usuarioEnviado);
					prepStat.setString(2,password);
					ResultSet resCons = prepStat.executeQuery();
					String requestURI = req.getRequestURI();
					if (resCons.next())
					{
						session.setAttribute("usuario1",usuarioEnviado);
						System.out.println("[" + new java.util.Date().toString() + "] - Poniendo usuario "+ usuarioEnviado);
						//usuario1= (String) session.getAttribute("usuario1");
						//System.out.println("[" + new Date().toString() + "] - Obteniendo usuario recien ingresado: " +usuario1);
						chain.doFilter(request, response);
					}else{
						// Si es un usuario inválido, cambia la petición para redireccionarlo al login.
						String toReplace = requestURI.substring(requestURI.indexOf("/") + 1, requestURI.length());
						String newURI = requestURI.replace(toReplace, "login.html");
						request.getRequestDispatcher(newURI).forward(request, response);
						// Aquí no continua con la cadena de filtros.
					}
				} catch (Exception e) {
					System.out.println("Error al procesar consulta " + e.getMessage());
				}
			} catch (Exception e) {
				System.out.println("Error al procesar la conexion "+e.getMessage()+"</h3>");
			} finally { // pase lo que pase retornamos la conexion
				try
				{
					con.close();
				} catch (Exception e) {
					System.out.println("Error en proceso " + e.getMessage());
				}
			}
		}else{
			System.out.println("[" + new java.util.Date().toString() + "] - Ya tiene usuario");
			chain.doFilter(request, response);
		}
		
	}

	public void destroy()
	{}
}
