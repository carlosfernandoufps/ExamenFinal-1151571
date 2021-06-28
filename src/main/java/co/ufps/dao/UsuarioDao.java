package co.ufps.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import co.ufps.entities.Usuario;

public interface UsuarioDao extends JpaRepository<Usuario, Long>{
	
}
