#import "/lib/global.typ": *

// Note that if any section gets too long you can always create new files and
// separate it out into multiple files. And then just import or include them in here.

// Titles shown in the title page. 
// You should do this manually and not just getting the string from the lang-database.yml, 
// because, if the title is long, it's will break in weird uncontrollable ways.
//
// #linguify("title", lang: "cs")
// #linguify("title", lang: "en")
#let title = (
  cs: (
    main: [
      Komponenta výukového serveru TI \ // -- \ 
      NP-úplné problémy 2
    ],
    sub: [
      Komponenta výukového serveru TI \ //-- \ 
      NP-úplné problémy 2
    ],
  ),
  en: (
    main: [
      Component of Learning Server for \
      Theoretical~Computer~Science \ // -- \
      NP-complete~problems~2
    ],
    sub: [
      Component of Learning Server for \
      Theoretical~Computer~Science \ // -- \
      NP-complete~problems~2
    ],
  )
)

// Abstracts. Are mandatory.
#let abstract = (
  en: [
    #lorem(20)

    #lorem(40)
  ],
  cs: [
    #lorem(40)

    #lorem(60)
  ]
)

// Keywords are put in a list. If the list is empty the page won't be rendered.
#let keywords = (
  en: (
    ..lorem(20).split(" "),
  ),
  cs: (
    ..lorem(20).split(" "),
  )
)

// Thanks. Is optional so I added `want-to-include` switch.
#let thanks = (want-to-include: true, body: [
  #lorem(30)
])

// List of symbols and abbreviations.
#let symbols-and-abbrevs = (
  ([GCC], [GNU C Compiler]),
  ([GNU], [GNU Is Not Linux]),
  ([NPTIME], [Non-Deterministic Polynomial Time]),
)

// Intro. Is mandatory.
#let intro = [
  #lorem(40)

  #lorem(40)

  #lorem(80)

  #lorem(160)

  #lorem(320)
]

// Conclusion. Is mandatory.
#let conclusion = [
  #lorem(20)

  #lorem(40)

  #lorem(80)
]

// Appnedices. Is optional, if you leave an empty list it won't render anything.
#let appendices = (

([Quick-Sort Implementation], [
    Implementation is in Haskell.

    #sourcecode(```hs
    quicksort [] = []
    quicksort (p:xs) = (quicksort lesser) ++ [p] ++ (quicksort greater)
      where
        lesser = filter (< p) xs
        greater = filter (>= p) xs
    ```)

    Yes. Very cool.
]),

([Binary Search], [
    #algorithm-figure(
      "Binary Search",
      {
        import algorithmic: *

        Procedure(
          "Binary-Search",
          ("A", "n", "v"),
          {
            Comment[Initialize the search range]
            Assign[$l$][$1$]
            Assign[$r$][$n$]
            LineBreak
            While(
              $l <= r$,
              {
                Assign([mid], FnInline[floor][$(l + r) / 2$])
                IfElseChain(
                  $A ["mid"] < v$,
                  {
                    Assign[$l$][$m + 1$]
                  },
                  [$A ["mid"] > v$],
                  {
                    Assign[$r$][$m - 1$]
                  },
                  Return[$m$],
                )
              },
            )
            Return[*null*]
          },
        )
      },
    )

    #algorithm-figure(
      "Variable Assignment",
      {
        import algorithmic: *
        Assign[$x$][$y$]
      },
    )
]),

([OpenGL Shader Compilation], [

  #figure(
    sourcecode(```cpp
      unsigned int OpenGLShader::Compile(
          const std::unordered_map<unsigned int, std::string>& sources
      ) const {
          EG_PROFILE_FUNCTION();

          EG_CORE_ASSERT(sources.size() >= 0 && sources.size() <= 3,
              "Can only have three shader sources \
              (vertex, geometry, fragment)!");

          unsigned int program;
          EG_OPENGL_CALL(program = glCreateProgram());

          std::vector<unsigned int> shaders(sources.size());
          for (const auto& [type, source] : sources) {
              auto shader = CompileSource(type, source);
              shaders.push_back(shader);
              EG_OPENGL_CALL(glAttachShader(program, shader));
          }

          EG_OPENGL_CALL(glLinkProgram(program));

          int status;
          EG_OPENGL_CALL(glGetProgramiv(program, GL_LINK_STATUS, &status));
          if (status == GL_FALSE) {
              int length;
              EG_OPENGL_CALL(glGetProgramiv(
                  program, GL_INFO_LOG_LENGTH, &length));

              std::vector<char> message(length);
              EG_OPENGL_CALL(glGetProgramInfoLog(
                  m_RendererID, length, &length, message.data()));

              EG_OPENGL_CALL(glDeleteShader(program));
              for (auto shader : shaders) {
                  EG_OPENGL_CALL(glDeleteShader(shader));
              }
              EG_CORE_ERROR("{}", message.data());
              EG_CORE_ASSERT(false, "Shader compilation failed!");
              return 0;
          }

          EG_OPENGL_CALL(glValidateProgram(program));
          for (auto shader : shaders) {
              EG_OPENGL_CALL(glDeleteShader(shader));
          }

          return program;
      }
    ```),
    caption: [C++ method for GLSL shader compilation],
  )

]),

([ASP.NET C\# code], [
  
  #figure(
    sourcecode[
    ```cs
    using System.Diagnostics;
    using System.Security.Claims;
    using CoworkingApp.Models;
    using CoworkingApp.Models.Misc;
    using CoworkingApp.Models.ViewModels;
    using CoworkingApp.Services.Repositories;
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;

    namespace CoworkingApp.Controllers.ViewControllers;

    public class HomeController
        (
            IWorkspaceRepository workspaceRepository,
            ICoworkingCenterRepository coworkingCenterRepository,
            IReservationRepository reservationRepository,
            IUserRepository userRepository
        ) 
        : Controller
    {
        [HttpGet]
        public async Task<IActionResult> Index()
        {
            var workspaces = await workspaceRepository.GetWorkspaces(new ()
            {
                HasPricing = true,
                IncludePricings = true,
                IncludeStatus = true,
            });

            var coworkingCenters = await coworkingCenterRepository.GetCenters(
                new CoworkingCenterFilter());

            return View(new HomeIndexViewModel()
            {
                Workspaces = workspaces,
                CoworkingCenters = coworkingCenters
            });
        }

        [HttpGet]
        [Authorize]
        public async Task<IActionResult> Dashboard(
            [FromQuery] ReservationSort reservationSort = ReservationSort.None)
        {
            var userId = User.GetUserId();

            if (userId == null)
            {
                return Unauthorized(new { message = "User not found" });
            }

            var reservations = await reservationRepository
                .GetReservations(new ReservationsFilter
                {
                    CustomerId = userId,
                    IsCancelled = false,
                    IncludeWorkspace = true,
                    Sort = reservationSort,
                });

            var user = (await userRepository.GetUsers(new UserFilter
            {
                UserId = userId
            })).Single();

            return View(new HomeDashboardViewModel 
            { 
                User = user,
                Reservations = reservations,
                ReservationSort = reservationSort,
            });
        }

        [HttpGet]
        public async Task<IActionResult> Privacy()
        {
            return View();
        }

        [ResponseCache(
            Duration = 0, 
            Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel 
            { 
                RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier 
            });
        }
    }
    ```],
    caption: [Computer program in C\# language]
  )

]),

)
