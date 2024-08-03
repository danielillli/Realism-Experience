document.addEventListener('DOMContentLoaded', function() {
    var menuOptions = document.querySelectorAll('#menu-options li');
    var selectedIndex = 0;
    var spawnerMenuContainer = document.getElementById('spawner-menu-container');
    var spawnerMenuOptions = document.querySelectorAll('#spawner-menu-options li');
    var spawnerSelectedIndex = 0;

    // Set initial focus on the first menu option
    menuOptions[selectedIndex].classList.add('active');
    menuOptions[selectedIndex].focus();

    // Handle keyboard navigation
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Backspace') {
            // Go back to the main menu options
            navigateToMainMenu();
        } else if (spawnerMenuContainer.classList.contains('hidden')) {
            // Handle keyboard navigation for the main menu options
            handleMainMenuNavigation(e);
        } else {
            // Handle keyboard navigation for the spawner menu options
            handleSpawnerMenuNavigation(e);
        }
    });

    // Event listener for menu option selection
    menuOptions.forEach(option => {
        option.addEventListener('click', function() {
            var selectedOption = this.innerText;
            // Call a function or trigger an event based on the selected option
            if (selectedOption === 'Repair Vehicle') {
                repairVehicle();
            } else if (selectedOption === 'Spawn Vehicle') {
                navigateToSpawner();
            }
        });
    });

    // Function to handle repairing the vehicle
    function repairVehicle() {
        // Call a function or trigger an event to repair the vehicle
        console.log('Repairing vehicle...');
        // Add server-side trigger if needed
    }

    // Function to navigate to the spawner section
    function navigateToSpawner() {
        // Hide the main menu options
        document.getElementById('menu-options').classList.add('hidden');

        // Show the spawner menu options
        spawnerMenuContainer.classList.remove('hidden');

        // Set initial focus on the first spawner menu option
        spawnerMenuOptions[spawnerSelectedIndex].classList.add('active');
        spawnerMenuOptions[spawnerSelectedIndex].focus();
    }

    // Function to handle going back to the main menu options
    function navigateToMainMenu() {
        // Hide the spawner menu options
        spawnerMenuContainer.classList.add('hidden');

        // Show the main menu options
        document.getElementById('menu-options').classList.remove('hidden');

        // Reset the selected index for the main menu options
        selectedIndex = 0;
        menuOptions[selectedIndex].classList.add('active');
        menuOptions[selectedIndex].focus();
    }

    // Function to handle keyboard navigation for the main menu options
    function handleMainMenuNavigation(e) {
        // Remove active class from the current selected option
        menuOptions[selectedIndex].classList.remove('active');

        if (e.key === 'ArrowDown' && selectedIndex < menuOptions.length - 1) {
            // Move down the menu options
            selectedIndex++;
        } else if (e.key === 'ArrowUp' && selectedIndex > 0) {
            // Move up the menu options
            selectedIndex--;
        } else if (e.key === 'Enter') {
            // Perform action based on the selected option
            if (selectedIndex === 1) {
                // Repair Vehicle option
                repairVehicle();
            } else if (selectedIndex === 0) {
                // Spawn Vehicle option
                navigateToSpawner();
            }
        }

        // Add active class to the newly selected option
        menuOptions[selectedIndex].classList.add('active');
        menuOptions[selectedIndex].focus();
    }

    // Function to handle keyboard navigation for the spawner menu options
    function handleSpawnerMenuNavigation(e) {
        // Remove active class from the current selected option
        spawnerMenuOptions[spawnerSelectedIndex].classList.remove('active');

        if (e.key === 'ArrowDown' && spawnerSelectedIndex < spawnerMenuOptions.length - 1) {
            // Move down the spawner menu options
            spawnerSelectedIndex++;
        } else if (e.key === 'ArrowUp' && spawnerSelectedIndex > 0) {
            // Move up the spawner menu options
            spawnerSelectedIndex--;
        } else if (e.key === 'Enter') {
            // Perform action based on the selected spawner option
            var selectedSpawner = spawnerMenuOptions[spawnerSelectedIndex].innerText;
            spawnVehicle(selectedSpawner);
        }

        // Add active class to the newly selected option
        spawnerMenuOptions[spawnerSelectedIndex].classList.add('active');
        spawnerMenuOptions[spawnerSelectedIndex].focus();
    }

    // Function to handle spawning the selected vehicle
    function spawnVehicle(vehicleName) {
        // Call a function or trigger an event to spawn the selected vehicle
        console.log('Spawning vehicle:', vehicleName);
        // Trigger server-side event to spawn the vehicle
    }
});
