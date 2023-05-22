﻿using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LawyerOffice.Models
{
     class Lawyer
    {
        database.DBconnection connect = new database.DBconnection();

        public bool insertNewLawyer(string firstname, string lastname, string specialization, int salary)
        {
            MySqlCommand command = new MySqlCommand("INSERT INTO `lawyer`(`name`, `surname`, `specialization`, `salary`) VALUES(@firstname, @lastname, @specialization, @salary)", connect.getconnection);
            command.Parameters.Add("@firstname", MySqlDbType.VarChar).Value = firstname;
            command.Parameters.Add("@lastname", MySqlDbType.VarChar).Value = lastname;
            command.Parameters.Add("@specialization", MySqlDbType.VarChar).Value = specialization;
            command.Parameters.Add("@salary", MySqlDbType.Int32).Value = salary;


            connect.openConnection();
            if (command.ExecuteNonQuery() == 1)
            {
                connect.closeConnection();
                return true;
            }
            else
            {
                connect.closeConnection();
                return false;
            }

        }

        public bool updateTheExistingLawyer(int id, string firstname, string lastname, string specialization, int salary)
        {
            MySqlCommand command = new MySqlCommand("UPDATE `lawyer` SET `name`=@firstname,`surname`=@lastname,`specialization`=@specialization,`salary`=@salary WHERE  `lawyerId`= @id", connect.getconnection);
            command.Parameters.Add("@id", MySqlDbType.Int32).Value = id;
            command.Parameters.Add("@firstname", MySqlDbType.VarChar).Value = firstname;
            command.Parameters.Add("@lastname", MySqlDbType.VarChar).Value = lastname;
            command.Parameters.Add("@specialization", MySqlDbType.VarChar).Value = specialization;
            command.Parameters.Add("@salary", MySqlDbType.Int32).Value = salary;

            connect.openConnection();
            if (command.ExecuteNonQuery() == 1)
            {
                connect.closeConnection();
                return true;
            }
            else
            {
                connect.closeConnection();
                return false;
            }

        }


        public bool deleteTheExistingLawyer(int id)
        {
            MySqlCommand command = new MySqlCommand("DELETE FROM `lawyer` WHERE `lawyerId`=@id", connect.getconnection);

            command.Parameters.Add("@id", MySqlDbType.Int32).Value = id;

            connect.openConnection();
            if (command.ExecuteNonQuery() == 1)
            {
                connect.closeConnection();
                return true;
            }
            else
            {
                connect.closeConnection();
                return false;
            }

        }

        public DataTable getThelistOfLawyers(MySqlCommand command)
        {
            command.Connection = connect.getconnection;
            MySqlDataAdapter adapter = new MySqlDataAdapter(command);
            DataTable table = new DataTable();
            adapter.Fill(table);
            return table;
        }

    }
}
