namespace HuskyTest
{
    /// <summary>
    /// Defines the <see cref="WeatherForecast" />.
    /// </summary>
    public class WeatherForecast
    {
        /// <summary>
        /// Gets or sets the Date.
        /// </summary>
        public DateOnly Date { get; set; }

        /// <summary>
        /// Gets or sets the TemperatureC.
        /// </summary>
        public int TemperatureC { get; set; }

        /// <summary>
        /// Gets the TemperatureF.
        /// </summary>
        public int TemperatureF => 32 + (int)(this.TemperatureC / 0.5556);

        /// <summary>
        /// Gets or sets the Summary.
        /// </summary>
        public string? Summary { get; set; }
    }
}
