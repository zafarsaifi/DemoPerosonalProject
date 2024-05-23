({
	//This is the Handler Method Which run every time when page will be load
	doInit: function (component, event, helper) {
		helper.getAccountData(component);
	},
	//This method is use for change the screen and move on the Popup modal
	handleCreateAccont: function (component, event, helper) {
		// var action = component.get("")
		component.set("v.isAccountModal", true);
	},
	//This methode is use for to insert the Account Record 
	insertNewAccount: function (component, event, helper) {
		console.log('Test+++++++++++++++++++++++++++');
		var name = component.find("acName").get("v.value");
		var phone = component.find("acPId").get("v.value");
		var inudstry = component.find("acIndId").get("v.value");
		console.log('name+++++++++++++++++++++++++++', name);
		console.log('Phone+++++++++++++++++++++++++++', phone);
		console.log('industry+++++++++++++++++++++++++++', inudstry);
		//createAccount is apex class(AuraCodeHandler.createAccount()) Method is use for to insert record in the salesforce database
		var action = component.get("c.createAccount");
		helper.showSpinner(component, true);
		action.setParams({ 'mname': name, 'mnumber': phone, 'Indus': inudstry });
		action.setCallback(this, function (response) {
			console.log("state", response.getState());
			var state = response.getState();
			console.log("state", state);
			if (state == "SUCCESS") {
				var result = response.getReturnValue();
				console.log("Result", result);
				
				helper.getAccountData(component);
				$A.get('e.force:refreshView').fire();
				component.set("v.isAccountModal", false);
				helper.showSuccess(component,event,helper);
				
			}
			else if (state === "ERROR") {
				alert("unknown error");
			}
			helper.showSpinner(component, false);
			

		});
		$A.enqueueAction(action);

	},
	editRecordHandler: function (Component, event, helper) {
		Component.set('v.isUpdateAccountRecordModal', true);
		helper.showSpinner(Component, true);
		var accountId = event.target.closest('[data-id]').dataset.id;
		Component.set("v.accId1", accountId);
		console.log('AccountId:' + accountId);
		var action = Component.get("c.updateAccountRecord");
		

		console.log('action==>' + action);
		action.setParams({ 'accId': accountId });
		action.setCallback(this, function (response) {
			console.log('state===>' + response.getState());
			if (response.getState() === "SUCCESS") {
				var result = response.getReturnValue();
				Component.set("v.AccountDetails", result);
				
			}
			else if (state === "ERROR") {
				alert("unknown error");
			}
			helper.showSpinner(Component, false);
		});
		$A.enqueueAction(action);

	},
	updateThisAccount: function (component, event,helper) {
		console.log("++++++++++++updateThisAccount");
		helper.showSpinner(component, true);
		var acc__Id = component.get("v.accId1")
		var name = component.find("acName").get("v.value");
		var phone = component.find("acPId").get("v.value");
		var industry = component.find("acIndId").get("v.value");
		var action = component.get("c.updateAccountRecordData");
		
		action.setParams({
			'acc_Name': name,
			'acc_Phone': phone,
			'acc_Industry': industry,
			'acc_Id': acc__Id
		});
		console.log("Action=========>")
		action.setCallback(this, function (response) {
			console.log("state==================>" + response.getState());
			if (response.getState() === "SUCCESS") {
				var result = response.getReturnValue();
				console.log("Result", result);
				$A.get('e.force:refreshView').fire();
				component.set("v.isUpdateAccountRecordModal", false);
				helper.getAccountData(component);

			}
			else if (state === "ERROR") {
				alert("unknown error");
			}
			helper.showSpinner(component, false);
		});
		$A.enqueueAction(action);

	},
	deleteRecordHandler: function (component, event, helper) {
		console.log('Delete Method==========>');
		var accountId = event.target.closest('[data-id]').dataset.id;

		console.log("Delete for Accont Id====>" + accountId);
		var action = component.get("c.deleteAccountRecord");
		helper.showSpinner(component, true);
		action.setParams({
			'acc_Id': accountId
		});
		action.setCallback(this, function (response) {
			console.log("state==================>" + response.getState());
			var state = response.getState();
			if (state === "SUCCESS") {
				var result = response.getReturnValue();
				console.log("Result", result);
				$A.get('e.force:refreshView').fire();
				component.set("v.isUpdateAccountRecordModal", false);
				helper.getAccountData(component);

				
			}
			else if (state === "ERROR") {
				alert("unknown error");
			}
			helper.showSpinner(component, false);
		});
		$A.enqueueAction(action);

	},
	// Here closeModal is use for to close the modal and move on the main screen 
	closeModel: function (Component) {
		Component.set("v.isAccountModal", false);
		Component.set("v.isUpdateAccountRecordModal", false);
	}






})