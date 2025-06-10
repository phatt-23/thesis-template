#import "/lib/global.typ": *

// Note that if any section gets too long you can always create new files and
// separate it out into multiple files. And then just import or include them in here.

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
  ([WTF], [What the fuck]),
  ([DPC], [Do $x^2$ pice]),
  ([KDPC], [Kurva do pice $->$ aaaah]),
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

  #lorem(160)

  #lorem(320)
]

// Appnedices. Is optional, if you leave an empty list it won't render anything.
#let appendices = (

    ([Qsort implementation], [
        Implementation is in Haskell.

        #sourcecode(```hs
        quicksort [] = []
        quicksort (p:xs) = (quicksort lesser) ++ [p] ++ (quicksort greater)
          where
            lesser = filter (< p) xs
            greater = filter (>= p) xs
        ```)

        Yes. Very cool.

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
    ]),

    ([Shit table], [
        #table(
          columns: (auto, auto),
          [A], [B],
          [B], [C],
          [C], [D],
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
        #lorem(20)

        #figure(
          sourcecode(```cpp
            unsigned int OpenGLShader::Compile(
                const std::unordered_map<unsigned int, std::string>& sources
            ) const
            {
                EG_PROFILE_FUNCTION();

                EG_CORE_ASSERT(sources.size() >= 0 && sources.size() <= 3,
                    "Can only have three shader sources \
                    (vertex, geometry, fragment)!");

                unsigned int program;
                EG_OPENGL_CALL(program = glCreateProgram());

                std::vector<unsigned int> shaders(sources.size());
                for (const auto& [type, source] : sources)
                {
                    auto shader = CompileSource(type, source);
                    shaders.push_back(shader);
                    EG_OPENGL_CALL(glAttachShader(program, shader));
                }

                EG_OPENGL_CALL(glLinkProgram(program));

                int status;
                EG_OPENGL_CALL(glGetProgramiv(program, GL_LINK_STATUS, &status));
                if (status == GL_FALSE)
                {
                    int length;
                    EG_OPENGL_CALL(glGetProgramiv(
                        program, GL_INFO_LOG_LENGTH, &length));

                    std::vector<char> message(length);
                    EG_OPENGL_CALL(glGetProgramInfoLog(
                        m_RendererID, length, &length, message.data()));

                    EG_OPENGL_CALL(glDeleteShader(program));
                    for (auto shader : shaders)
                    {
                        EG_OPENGL_CALL(glDeleteShader(shader));
                    }
                    EG_CORE_ERROR("{}", message.data());
                    EG_CORE_ASSERT(false, "Shader compilation failed!");
                    return 0;
                }

                EG_OPENGL_CALL(glValidateProgram(program));
                for (auto shader : shaders)
                {
                    EG_OPENGL_CALL(glDeleteShader(shader));
                }

                return program;
            }
          ```),
          caption: [C++ method for GLSL shader compilation],
        )

    ]),

)
