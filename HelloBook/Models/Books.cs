﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace HelloBook.Models;

public partial class Books
{
    public int Id { get; set; }

    public string Title { get; set; }

    public int Author_id { get; set; }

    public int Price { get; set; }

    public DateTime Published_date { get; set; }

    public int Stock { get; set; }

    public virtual Authors Author { get; set; }
}