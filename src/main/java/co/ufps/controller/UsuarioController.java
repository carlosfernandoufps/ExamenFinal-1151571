package co.ufps.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import co.ufps.dao.UsuarioDao;
import co.ufps.entities.Rol;
import co.ufps.entities.Usuario;

@Controller
public class UsuarioController {
	
	@Autowired
	UsuarioDao usuarioDao;
	
	
	@GetMapping("/registrar")
	public String registrarUsuario(@RequestParam(name="usuario") String usuario,
			@RequestParam(name="email") String email,
			@RequestParam(name="pass") String pass) {
			
		Usuario usuariodb = new Usuario();
		usuariodb.setUsuario(usuario);
		usuariodb.setEmail(email);
		usuariodb.setPass(pass);
		usuariodb.setRole(new Rol(1L, "Usuario"));
		usuarioDao.save(usuariodb);
		return "list";
	}
	
}
