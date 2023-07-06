function getMedicationInfo() {
	const medicationName = document.getElementById("medication-name").value;
	const url = `https://api.fda.gov/drug/label.json?search=openfda.brand_name:${medicationName}`;
	fetch(url)
		.then(response => response.json())
		.then(data => {
			const medicationInfo = data.results[0];
			const medicationInfoHtml = `
						<div class="container p-5">
						<h2>${medicationInfo.openfda.brand_name}</h2>
						<h3>${medicationInfo.active_ingredient}</h3>
						<p><strong>Generic Name:</strong> ${medicationInfo.openfda.generic_name}</p>
						<p><strong>Purpose:</strong> ${medicationInfo.purpose}</p>
						<p><strong>Class:</strong> ${medicationInfo.openfda.pharm_class_epc}</p>
						<p><strong>Manufacturer:</strong> ${medicationInfo.openfda.manufacturer_name}</p>
						<p><strong>Indications and Usage:</strong> ${medicationInfo.dosage_and_administration}</p>
						<p><strong>Warnings:</strong> ${medicationInfo.warnings}</p></div>
					`;

			document.getElementById("medication-info").innerHTML = medicationInfoHtml;
		})
		.catch(error => console.error(error));
	event.preventDefault();
}