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
		
		//--a. 5 consultas b�sicas envolvendo os comandos distinct, order by,
		//--count(*), like, in e fun��es de manipula��o de datas.
		Consultas.consultaA1(conn);
		
		//--1) Quantidade de esp�cies distintas
		//Consultas.consultaA1(conn);
		
		//--2) Todos dinossauros do mais velho ao mais novo
		//Consultas.consultaA2(conn);
		
		//--3) Todas as esp�cies que n�o possuem 'sauro' no nome
		//Consultas.consultaA3(conn)
		
		//--4) Todas dinossaouros f�meas que pesam menos que 10000kg e n�o s�o herbivoras
		//Consultas.consultaA4(conn)
		
		//--5) Todas os ve�culos que n�o est�o ativos
		//Consultas.consultaA5(conn)
		
		
		
		//--b. 5 consultas das quais 2 envolvam jun��es entre duas tabelas e 3
		//--envolvam jun��es entre tr�s ou mais tabelas.
		
		//--1) Quantidade de dinossauros e de esp�cies por �rea
		//Consultas.consultaB1(conn)
		
		//--2) Quantidade de funcionarios por funcao
		//Consultas.consultaB2(conn)
		
		//--3) Retorna os Eventos que possuem Tyranosaurus a partir da data e hora atual
		//Consultas.consultaB3(conn)
		
		//--4) Retorna os ve�culos que est�o com algum funcion�rio
		//Consultas.consultaB4(conn)
		
		//--5) Retorna a quantidade de funcion�rios, a quantidade de dinossauros e a rela��o funcion�rio/dinossauro para cada �rea
		//Consultas.consultaB5(conn)
		
		
		
		//--c. 5 consultas envolvendo group by e having, juntamente com fun��es
		//--de agrega��o.
		
		//--1) Retorna quantidade de ve�culos por ano
		//Consultas.consultaB4(conn)
		
		
		
		
		conn.close();
	}

}
