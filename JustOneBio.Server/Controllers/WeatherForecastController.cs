using JustOneBio.Server.Data;
using JustOneBio.Server.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace JustOneBio.Server.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class WeatherForecastController : ControllerBase
    {
        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        private readonly ILogger<WeatherForecastController> _logger;
        private JustonebioMainContext _context;

        public WeatherForecastController(ILogger<WeatherForecastController> logger, JustonebioMainContext context)
        {
            _context = context;
            _logger = logger;
        }

        [HttpGet(Name = "GetWeatherForecast")]
        public IEnumerable<User> Get()
        {
            _context.Users.Add(new User { Username = "test", Password="" });
            _context.SaveChanges();
            return _context.Users.ToArray();
        }
    }
}
