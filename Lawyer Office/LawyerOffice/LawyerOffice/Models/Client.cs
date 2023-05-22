using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Data;
using MySqlX.XDevAPI;
using Org.BouncyCastle.Utilities.Collections;
using System.Xml.Linq;

namespace LawyerOffice.Models
{
    class Client
    {
        database.DBconnection connect = new database.DBconnection();

        public bool insertNewClient(string firstname, string lastname, string address, string phone, string email)
        {
            MySqlCommand command = new MySqlCommand("INSERT INTO `client`(`name`, `surname`, `address`, `phoneNumber`, `email`) VALUES(@firstname, @lastname, @address, @phone, @email)", connect.getconnection);
            command.Parameters.Add("@firstname", MySqlDbType.VarChar).Value = firstname;
            command.Parameters.Add("@lastname", MySqlDbType.VarChar).Value = lastname;
            command.Parameters.Add("@address", MySqlDbType.VarChar).Value = address;
            command.Parameters.Add("@phone", MySqlDbType.VarChar).Value = phone;
            command.Parameters.Add("@email", MySqlDbType.VarChar).Value = email;


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

        public bool updateTheExistingClient(int id, string firstname, string lastname, string address, string phone, string email)
        {
            MySqlCommand command = new MySqlCommand("UPDATE `client` SET `name`=@firstname,`surname`=@lastname,`address`=@address,`phoneNumber`=@phone,`email`=@email WHERE  `clientId`= @id", connect.getconnection);
            command.Parameters.Add("@id", MySqlDbType.Int32).Value = id;
            command.Parameters.Add("@firstname", MySqlDbType.VarChar).Value = firstname;
            command.Parameters.Add("@lastname", MySqlDbType.VarChar).Value = lastname;
            command.Parameters.Add("@address", MySqlDbType.VarChar).Value = address;
            command.Parameters.Add("@phone", MySqlDbType.VarChar).Value = phone;
            command.Parameters.Add("@email", MySqlDbType.VarChar).Value = email;

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


        public bool deleteTheExistingClient(int id)
        {
            MySqlCommand command = new MySqlCommand("DELETE FROM `client` WHERE `clientId`=@id", connect.getconnection);

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

        public DataTable getThelistOfClients(MySqlCommand command)
        {
            command.Connection = connect.getconnection;
            MySqlDataAdapter adapter = new MySqlDataAdapter(command);
            DataTable table = new DataTable();
            adapter.Fill(table);
            return table;
        }

    }
}
