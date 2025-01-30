using System;
using HelloBook.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace HelloBook.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HelloBookController : ControllerBase
    {
        private readonly HelloBookContext _context;

        public HelloBookController(HelloBookContext context)
        {
            _context = context;
        }

        // GET: api/<HelloBookController>
        [HttpGet]
        public IActionResult GetBooks([FromQuery] string titolo, [FromQuery] string nazionalita)
        {

            var query = _context.Books.Include(l => l.Author).AsQueryable();

            // Controllo Titolo in Books
            if (!string.IsNullOrEmpty(titolo))
            {
                query = query.Where(l => l.Title.Contains(titolo));
            }

            // Controllo Nazionality in Author
            if (!string.IsNullOrEmpty(nazionalita))
            {
                query = query.Where(l => l.Author.Nationality.Contains(nazionalita));
            }

            // Ordinamento Stock e Price dal più alto al più basso
            query = query.OrderByDescending(l => l.Stock).ThenByDescending(l => l.Price);

            var libri = query.ToList();

            return Ok(libri);
        }
    }
}
