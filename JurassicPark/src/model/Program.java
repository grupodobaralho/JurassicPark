package model;

import java.sql.Connection;
import java.sql.SQLException;

/***
 * Main program class.
 */
public class Program {

	public static void main(String[] args) throws SQLException {
		
		// Gets a database connection.
		Connection conn = Database.getConnection();
		
		//--a. 5 consultas básicas envolvendo os comandos distinct, order by,
		//--count(*), like, in e funções de manipulação de datas.
		Consultas.consultaA1(conn);
		
		//--1) Quantidade de espécies distintas
		//Consultas.consultaA1(conn);
		
		//--2) Todos dinossauros do mais velho ao mais novo
		//Consultas.consultaA2(conn);
		
		//--3) Todas as espécies que não possuem 'sauro' no nome
		//Consultas.consultaA3(conn)
		
		//--4) Todas dinossaouros fêmeas que pesam menos que 10000kg e não são herbivoras
		//Consultas.consultaA4(conn)
		
		//--5) Todas os veículos que não estão ativos
		//Consultas.consultaA5(conn)
		
		
		
		//--b. 5 consultas das quais 2 envolvam junções entre duas tabelas e 3
		//--envolvam junções entre três ou mais tabelas.
		
		//--1) Quantidade de dinossauros e de espécies por área
		//Consultas.consultaB1(conn)
		
		//--2) Quantidade de funcionarios por funcao
		//Consultas.consultaB2(conn)
		
		//--3) Retorna os Eventos que possuem Tyranosaurus a partir da data e hora atual
		//Consultas.consultaB3(conn)
		
		//--4) Retorna os veículos que estão com algum funcionário
		//Consultas.consultaB4(conn)
		
		//--5) Retorna a quantidade de funcionários, a quantidade de dinossauros e a relação funcionário/dinossauro para cada área
		//Consultas.consultaB5(conn)
		
		
		
		//--c. 5 consultas envolvendo group by e having, juntamente com funções
		//--de agregação.
		
		//--1) Retorna quantidade de veículos por ano
		//Consultas.consultaB4(conn)
		
		
		
		
		conn.close();
	}

}
