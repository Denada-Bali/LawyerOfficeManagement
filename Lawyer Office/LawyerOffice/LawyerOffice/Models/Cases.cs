using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LawyerOffice.Models
{
     class Cases
    {
        database.DBconnection connect = new database.DBconnection();
        public bool insertNewCase(int clientId, string lawyername, DateTime startDate, string statusCase)
        {
            MySqlCommand command = new MySqlCommand("INSERT INTO `cases`(`clientId`, `lawyerId`, `startDate`, `statusCase`) VALUES (@clientId, (SELECT lawyerId FROM `lawyer` WHERE name = @lawyername), @startDate, @statusCase)", connect.getconnection);

          //  MySqlCommand command = new MySqlCommand("INSERT INTO `cases`(`clientId`, `name`, `startDate`, `statusCase`) VALUES (@clientId,@lawyername,@startDate,@statusCase)", connect.getconnection);
            
            command.Parameters.Add("@clientId", MySqlDbType.Int32).Value = clientId;
            command.Parameters.Add("@lawyername", MySqlDbType.VarChar).Value = lawyername;
            command.Parameters.Add("@startDate", MySqlDbType.Date).Value = startDate;
            command.Parameters.Add("@statusCase", MySqlDbType.VarChar).Value = statusCase;
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

        public bool updateAnExistingCase(int clientId, int lawyerId, DateTime startDate, string statusCase)
        {
            MySqlCommand command = new MySqlCommand("UPDATE `cases` SET `startDate`=@startDate,`statusCase`=@statusCase WHERE `clientId`=@clientId AND `lawyerId`=@lawyerId", connect.getconnection);

            command.Parameters.Add("@clientId", MySqlDbType.Int32).Value = clientId;
            command.Parameters.Add("@lawyerId", MySqlDbType.Int32).Value = lawyerId;
            command.Parameters.Add("@startDate", MySqlDbType.Date).Value = startDate;
            command.Parameters.Add("@statusCase", MySqlDbType.VarChar).Value = statusCase;

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

        public bool deleteTheExistingCase(int id)
        {
            MySqlCommand command = new MySqlCommand("DELETE FROM `cases` WHERE `CaseId`=@id", connect.getconnection);

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

        public DataTable getThelistOfCases(MySqlCommand command)
        {
            command.Connection = connect.getconnection;
            MySqlDataAdapter adapter = new MySqlDataAdapter(command);
            DataTable table = new DataTable();
            adapter.Fill(table);
            return table;
        }

    }
}
