#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
    name = "CMD All Players",
    author = "Seu Nome",
    description = "Executa um comando em todos os jogadores",
    version = "1.0",
    url = ""
};

public void OnPluginStart()
{
    RegAdminCmd("sm_cmdall", Command_ExecuteAll, ADMFLAG_ROOT, "Executa um comando em todos os jogadores");
}

public Action Command_ExecuteAll(int client, int args)
{
    // Verifica se o comando foi usado corretamente
    if (args < 1)
    {
        ReplyToCommand(client, "[SM] Use: sm_cmdall <comando>");
        return Plugin_Handled;
    }

    // Pega o comando completo
    char fullCommand[256];
    GetCmdArgString(fullCommand, sizeof(fullCommand));

    // Executa o comando para todos os jogadores
    for (int i = 1; i <= MaxClients; i++)
    {
        // Verifica se o jogador está conectado e é válido
        if (IsClientConnected(i) && IsClientInGame(i))
        {
            // Envia o comando para o console do jogador
            ClientCommand(i, fullCommand);
        }
    }

    // Informa o admin que o comando foi executado
    //ReplyToCommand(client, "[SM] Comando '%s' executado para todos os jogadores.", fullCommand);

    return Plugin_Handled;
}