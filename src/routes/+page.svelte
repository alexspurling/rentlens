<script>

    import '$lib/style.css';

    // Initialize the slider values
    let rentalProperties = 5000000;
    let rentalPropertiesPriceIncreasePercent = 50;
    let rentIncreaseChallengesPercent = 10;
    let conversionRatePercent = 10;


    // Compute the product
    $: rentalPropertiesPriceIncrease = rentalProperties * rentalPropertiesPriceIncreasePercent / 100;
    $: rentIncreaseChallenges = rentalPropertiesPriceIncrease * rentIncreaseChallengesPercent / 100;
    $: fullReports = conversionRatePercent * rentIncreaseChallenges / 100;

    let currentUnit = "year";
    let divisor = 1;

    function selectUnit(unit) {
        currentUnit = unit;
        if (unit === 'day') {
            divisor = 365;
        } else if (unit === 'month') {
            divisor = 12;
        } else {
            divisor = 1;
        }
    }
</script>

<svelte:head>
    <title>Property API Request Calculator</title>
</svelte:head>

<main>
    <h1>API Requests Calculator</h1>

    <div style="margin-bottom: 1rem;">
        <label>Number of rental properties in England
            <input bind:value={rentalProperties} />: {rentalProperties}
        </label>
    </div>

    <div style="margin-bottom: 1rem;">
        <label>Rental properties with rent increase per year: {rentalPropertiesPriceIncreasePercent}%
            <input type="range" min="0" max="100" bind:value={rentalPropertiesPriceIncreasePercent} />= {rentalPropertiesPriceIncrease} properties.
        </label>
    </div>

    <div style="margin-bottom: 1rem;">
        <label>Percent rent increase challenged: {rentIncreaseChallengesPercent}%
            <input type="range" min="0" max="100" bind:value={rentIncreaseChallengesPercent} />= {rentIncreaseChallenges} challenges per year.
        </label>
    </div>

    <div style="margin-bottom: 1rem;">
        <label>Conversion rate per visitor: {conversionRatePercent}%
            <input type="range" min="0" max="100" bind:value={conversionRatePercent} />
        </label>
    </div>


    <!-- Unit buttons -->
    <div style="margin-bottom: 1rem;">
        Per
        {#each ['year', "month", 'day'] as unit}
            <button
                    on:click={() => selectUnit(unit)}
                    class:selected={currentUnit === unit}
                    style="margin-right: 0.5rem;"
            >
                {unit.charAt(0).toUpperCase() + unit.slice(1)}
            </button>
        {/each}
    </div>

    <div style="margin-bottom: 1rem;">
        Basic reports: {Math.floor(rentIncreaseChallenges / divisor)}
        <ul>
            <li>Propertydata.co.uk for postcode lookup and rental price estimate</li>
        </ul>
    </div>

    <div style="margin-bottom: 1rem;">
        Full reports: {Math.floor(fullReports / divisor)}
        <ul>
            <li>EPC lookup for floor area and EPC rating adjustment</li>
            <li>Gemini / ChatGPT for AI image analysis</li>
            <li>Rail and road noise data from DEFRA</li>
            <li>Google maps display for comparable properties and streetview</li>
        </ul>
    </div>

</main>

<style>
    input[type="range"] {
        width: 100%;
    }
</style>
