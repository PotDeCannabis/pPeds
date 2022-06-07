Settings = {

	command = 'setped',
	DefaultPedDB = 'none',
	RequiredGroup = {
		['group1'] = "owner", 
    	['group2'] = "superadmin", 
    	['group3'] = "admin", 
        ['group4'] = "", 
    	['group5'] = "", 
    	['group6'] = "" },
}

Settings.DeletePed = {

	command = 'deleteped',
	command2 = '/deleteped',
	description = 'Supprimer le ped du joueur.',
	['id'] = 'Id du joueur.',
	['deleteFromDatabase'] = 'Taper true pour le supprimer.'

}

Settings.chatSuggestion = {

	command = '/setped',
	description = 'Ajouter un ped au joueur.',
	['id'] = 'Id du joueur.',
	['ped'] = 'Taper le nom du ped.',
    
}