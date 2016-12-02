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
		System.out.println("-------------------------------CONSULTAS A-------------------------------");
		System.out.println("a. 5 consultas b�sicas envolvendo os comandos distinct, order by, ");
		System.out.println("count(*), like, in e fun��es de manipula��o de datas.\n");
		
		//--A1) Quantidade de esp�cies distintas
		Consultas.consultaA1(conn);
		
		//--A2) Todos dinossauros do mais velho ao mais novo
		Consultas.consultaA2(conn);
		
		//--A3) Todas as esp�cies que n�o possuem 'sauro' no nome
		Consultas.consultaA3(conn);
		
		//--A4) Todas dinossaouros f�meas que pesam menos que 10000kg e n�o s�o herbivoras
		Consultas.consultaA4(conn);
		
		//--A5) Todas os ve�culos que n�o est�o ativos
		Consultas.consultaA5(conn);
		
		
		
		//--b. 5 consultas das quais 2 envolvam jun��es entre duas tabelas e 
		//--3 envolvam jun��es entre tr�s ou mais tabelas.
		System.out.println("\n\n\n-------------------------------CONSULTAS B-------------------------------");
		System.out.println("b. 5 consultas das quais 2 envolvam jun��es entre duas tabelas e ");
		System.out.print("3 envolvam jun��es entre tr�s ou mais tabelas.");
		
		//--B1) Quantidade de dinossauros e de esp�cies por �rea
		Consultas.consultaB1(conn);
		
		//--B2) Quantidade de funcionarios por funcao
		Consultas.consultaB2(conn);
		
		//--B3) Retorna os Eventos que possuem Tyranosaurus a partir da data e hora atual
		Consultas.consultaB3(conn);
		
		//--B4) Retorna os ve�culos que est�o com algum funcion�rio
		Consultas.consultaB4(conn);
		
		//--B5) Retorna a quantidade de funcion�rios, a quantidade de dinossauros e a rela��o funcion�rio/dinossauro para cada �rea
		Consultas.consultaB5(conn);
		
		
		
		//--c. 5 consultas envolvendo group by e having, juntamente com fun��es
		//--de agrega��o.
		System.out.println("\n\n\n-------------------------------CONSULTAS C-------------------------------");
		System.out.println("c. 5 consultas envolvendo group by e having, juntamente com fun��es");
		System.out.print("de agrega��o.");
				
		//--C1) Retorna quantidade de ve�culos por ano
		Consultas.consultaC1(conn);
		
		//--C2) Retorna a media salarial dos funcion�rios por �rea
		Consultas.consultaC2(conn);
		
		//--C3) Status da capacidade de transporte da frota
		Consultas.consultaC3(conn);
		
		//--C4) Mostra as areas em que o menor sal�rio � ao menos 6000
		Consultas.consultaC4(conn);
		
		//--C5) Mostra as �reas que tiverem eventos e somaram menos de 500 pessoas de p�blico em eventos no �ltimo m�s
		Consultas.consultaC5(conn);
		
		
		
		//--d. 5 consultas envolvendo sub-consultas.
		System.out.println("\n\n\n-------------------------------CONSULTAS D-------------------------------");
		System.out.print("d. 5 consultas envolvendo sub-consultas.");
		
		//--D1) Nome e altura dos dinossauros que habitam areas maiores de 5000m2
		Consultas.consultaD1(conn);
		
		//--D2) Nome e sexo dos funcion�rios que trabalham em terreno arenoso
		Consultas.consultaD2(conn);
		
		//--D3) Mostra funcionarios que trabalham no Sul
		Consultas.consultaD3(conn);
		
		//--D4) Mostra fun��es que trabalham no coberto e as �reas 
		Consultas.consultaD4(conn);
		
		//--D5) Mostra cada funcion�rio, e sua fun��o, que tem fator multiplicativo maior que 1.5 e sal�rio base maior que 5000
		Consultas.consultaD5(conn);
		
		
		conn.close();
	}

}
