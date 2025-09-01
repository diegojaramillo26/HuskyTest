namespace HuskyTest.Controllers
{
    using Microsoft.AspNetCore.Mvc;

    /// <summary>
    /// Defines the <see cref="WeatherForecastController" />.
    /// </summary>
    [ApiController]
    [Route("[controller]")]
    public class WeatherForecastController : ControllerBase
    {
        /// <summary>
        /// Defines the Summaries.
        /// </summary>
        private static readonly string[] Summaries =
        [
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching",
        ];

        /// <summary>
        /// Defines the logger.
        /// </summary>
        private readonly ILogger<WeatherForecastController> _logger;

        /// <summary>
        /// Initializes a new instance of the <see cref="WeatherForecastController"/> class.
        /// </summary>
        /// <param name="logger">The logger<see cref="ILogger{WeatherForecastController}"/>Hello.</param>
        public WeatherForecastController(ILogger<WeatherForecastController> logger)
        {
            _logger = logger;
        }

        /// <summary>
        /// The Get.
        /// </summary>
        /// <returns>The <see cref="IEnumerable{WeatherForecast}"/>hello.</returns>
        [HttpGet(Name = "GetWeatherForecast")]
        public IEnumerable<WeatherForecast> Get()
        {
            _logger.LogInformation("Hola");
            return [.. Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
                TemperatureC = Random.Shared.Next(-20, 55),
                Summary = Summaries[Random.Shared.Next(Summaries.Length)],
            })];
        }
    }
}
